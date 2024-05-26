package dev.mvc.contents;

import java.util.ArrayList;
import java.util.HashMap;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import dev.mvc.category.CategoryProcessInterface;
import dev.mvc.category.CategoryVO;
import dev.mvc.category.CategoryVOMenu;
import dev.mvc.member.MemberProcInter;
import dev.mvc.tool.Tool;
import dev.mvc.tool.Upload;

@RequestMapping(value="/contents")
@Controller
public class ContentsCont {
  @Autowired
  @Qualifier("dev.mvc.member.MemberProc")  // @Service("dev.mvc.member.MemberProc")
  private MemberProcInter memberProc;
  
  @Autowired
  @Qualifier("dev.mvc.category.CategoryProcess")  // @Component("dev.mvc.category.CategoryProcess")
  private CategoryProcessInterface categoryProcess;
  
  @Autowired
  @Qualifier("dev.mvc.contents.ContentsProc") // @Component("dev.mvc.contents.ContentsProc")
  private ContentsProcInter contentsProc;
  
  public ContentsCont () {
    System.out.println("-> ContentsCont created.");
  }
  
  /**
   * POST 요청시 새로고침 방지, POST 요청 처리완료 -> redirect -> url -> GET -> forward -> html
   * POST → url → GET → 데이터 전송
   * @return
   */
  @GetMapping(value="/msg")
  public String msg(Model model, String url){
    ArrayList<CategoryVOMenu> menu = this.categoryProcess.menu();
    model.addAttribute("menu", menu);

    return url; // /forward, /templates/...
  }
  
  // 등록 폼, contents 테이블은 FK로 categoryno를 사용함.
  // http://localhost:9094/contents/create  X
  // http://localhost:9094/contents/create?categoryno=1  // categoryno 변수값을 보내는 목적
  // http://localhost:9094/contents/create?categoryno=2
  // http://localhost:9094/contents/create?categoryno=5
  @GetMapping(value="/create")
  public String create(Model model, ContentsVO contentsVO, int categoryno) {
    ArrayList<CategoryVOMenu> menu = this.categoryProcess.menu();
    model.addAttribute("menu", menu);
    
    CategoryVO categoryVO = this.categoryProcess.read(categoryno); // create.html에 카테고리 정보를 출력하기위한 목적
    model.addAttribute("categoryVO", categoryVO);
    
    return "contents/create"; // /templates/contents/create.html
  }

  /**
   * 등록 처리 http://localhost:9094/contents/create
   * 
   * @return
   */
  @PostMapping(value = "/create")
  public String create(HttpServletRequest request, 
                                           HttpSession session, 
                                           Model model,
                                           ContentsVO contentsVO,
                                           RedirectAttributes ra) {
    
    int categoryNO = contentsVO.getCategoryno(); // 카테고리 글 번호 가져오기
    
    if (memberProc.isMemberAdmin(session)) { // 관리자로 로그인한경우
      // ------------------------------------------------------------------------------
      // 파일 전송 코드 시작
      // ------------------------------------------------------------------------------
      String file1 = "";          // 원본 파일명 image
      String file1saved = "";   // 저장된 파일명, image
      String thumb1 = "";     // preview image

      String upDir =  Contents.getUploadDir(); // 파일을 업로드할 폴더 준비
      System.out.println("-> upDir: " + upDir);
      
      // 전송 파일이 없어도 file1MF 객체가 생성됨.
      // <input type='file' class="form-control" name='file1MF' id='file1MF' 
      //           value='' placeholder="파일 선택">
      MultipartFile mf = contentsVO.getFile1MF();
      
      file1 = mf.getOriginalFilename(); // 원본 파일명 산출, 01.jpg
      System.out.println("-> 원본 파일명 산출 file1: " + file1);
      
      long size1 = mf.getSize();  // 파일 크기
      if (size1 > 0) { // 파일 크기 체크, 파일을 올리는 경우
        if (Tool.checkUploadFile(file1) == true) { // 업로드 가능한 파일인지 검사
          // 파일 저장 후 업로드된 파일명이 리턴됨, spring.jsp, spring_1.jpg, spring_2.jpg...
          file1saved = Upload.saveFileSpring(mf, upDir); 
          
          if (Tool.isImage(file1saved)) { // 이미지인지 검사
            // thumb 이미지 생성후 파일명 리턴됨, width: 200, height: 150
            thumb1 = Tool.preview(upDir, file1saved, 200, 150); 
          }

          contentsVO.setFile1(file1);   // 순수 원본 파일명
          contentsVO.setFile1saved(file1saved); // 저장된 파일명(파일명 중복 처리)
          contentsVO.setThumb1(thumb1);      // 원본이미지 축소판
          contentsVO.setSize1(size1);  // 파일 크기

        } else { // 전송 못하는 파일 형식
          ra.addFlashAttribute("code", "check_upload_file_fail"); // 업로드 할 수 없는 파일
          ra.addFlashAttribute("cnt", 0); // 업로드 실패
          ra.addFlashAttribute("url", "/contents/msg"); // msg.html, redirect parameter 적용
          return "redirect:/contents/msg"; // Post -> Get - param...
        }
      } else { // 글만 등록하는 경우
        System.out.println("-> 글만 등록");
      }
      
      // ------------------------------------------------------------------------------
      // 파일 전송 코드 종료
      // ------------------------------------------------------------------------------
      
      // Call By Reference: 메모리 공유, Hashcode 전달
      int memberno = (int)session.getAttribute("memberno"); // memberno FK
      contentsVO.setMemberno(memberno);
      int cnt = this.contentsProc.create(contentsVO); 
      
      // ------------------------------------------------------------------------------
      // PK의 return
      // ------------------------------------------------------------------------------
      // System.out.println("--> contentsno: " + contentsVO.getContentsno());
      // mav.addObject("contentsno", contentsVO.getContentsno()); // redirect parameter 적용
      // ------------------------------------------------------------------------------
      
      if (cnt == 1) {
        // type 1, 재업로드 발생
        // return "<h1>파일 업로드 성공</h1>"; // 연속 파일 업로드 발생
        
        // type 2, 재업로드 발생
        // model.addAttribute("cnt", cnt);
        // model.addAttribute("code", "create_success");
        // return "contents/msg";
        
        // type 3 권장
        // return "redirect:/contents/list_all";  // /templates/contents/list_all.html
        
        // System.out.println("-> contentsVO.getCategoryno(): " + contentsVO.getCategoryno());
        // ra.addFlashAttribute("categoryno", contentsVO.getCategoryno()); // controller -> controller: X
        
        System.out.println("등록 성공");
        System.out.println("-> categoryNO: " + contentsVO.getCategoryno());
        this.categoryProcess.cnt_plus(contentsVO.getCategoryno()); // 관련 글 수 증가
        
        ra.addAttribute("categoryno", contentsVO.getCategoryno()); // controller -> controller: O
        ra.addAttribute("categoryNO", categoryNO);
        return "redirect:/contents/list_by_categoryno";
        
        // return "redirect:/contents/list_by_categoryno?categoryno=" + contentsVO.getCategoryno();  // /templates/contents/list_by_categoryno.html
      } else {
        ra.addFlashAttribute("code", "create_fail"); // DBMS 등록 실패
        ra.addFlashAttribute("cnt", 0); // 업로드 실패
        ra.addFlashAttribute("url", "/contents/msg"); // msg.html, redirect parameter 적용
        return "redirect:/contents/msg"; // Post -> Get - param...
      }   
    } else {  //  로그인 실패 한 경우
      return "redirect:/member/login_form_need";  // /member/login_cookie_need.html
    }
  }
  
  /**
   * 전체 목록, 관리자만 사용 가능
   * http://localhost:9094/contents/list_all.do
   * @return
   */
  @GetMapping(value="/list_all")
  public String list_all(HttpSession session, Model model) {
    // System.out.println("-> list_all");
    ArrayList<CategoryVOMenu> menu = this.categoryProcess.menu();
    model.addAttribute("menu", menu);
    
    if (this.memberProc.isMemberAdmin(session)) {
      ArrayList<ContentsVO> list = this.contentsProc.list_all();
      
      model.addAttribute("list", list);
      return "contents/list_all";
      
    } else {
      return "redirect:/member/login_form_need";
    }    
  }
  
  /**
   * 카테고리별 목록 + 검색 + 페이징
   * http://localhost:9094/contents/list_by_categoryno?categoryno=5
   * @return
   */
  @GetMapping(value="/list_by_categoryno")
  public String list_by_categoryno_search_paging(HttpSession session, Model model, 
                                                    int categoryno, 
                                                    @RequestParam(name="word", defaultValue = "") String word,
                                                    @RequestParam(name="now_page", defaultValue="1") int now_page) {
    
    // 메뉴 가져오기
    ArrayList<CategoryVOMenu> menu = this.categoryProcess.menu();
    model.addAttribute("menu", menu);
    
    CategoryVO categoryVO = this.categoryProcess.read(categoryno);
    model.addAttribute("categoryVO", categoryVO);
  
    word = Tool.checkNull(word).trim();
   
    HashMap<String, Object> map = new HashMap<>();
    map.put("categoryno", categoryno);
    map.put("word", word);
    map.put("now_page", now_page);
   
    // 페이징 목록
    ArrayList<ContentsVO> list = this.contentsProc.list_by_categoryno_search_paging(map);
    model.addAttribute("list", list);
    
    // System.out.println("-> size: " + list.size());
    model.addAttribute("word", word);
    
    // 페이징 버튼 목록
    int search_count = this.contentsProc.list_by_categoryno_search_count(map); // 갯수 가져오기
    String paging = this.contentsProc.pagingBox(categoryno, 
                                                            now_page, 
                                                            word, 
                                                            "/contents/list_by_categoryno", 
                                                            search_count, 
                                                            Contents.RECORD_PER_PAGE, 
                                                            Contents.PAGE_PER_BLOCK);
    
    model.addAttribute("paging", paging);
    model.addAttribute("now_page", now_page);
    model.addAttribute("search_count", search_count);
    
    
    // 일련 변호 생성: 레코드 갯수 - ((현재 페이지수 -1) * 페이지당 레코드 수)
    int no = search_count - ((now_page - 1) * Contents.RECORD_PER_PAGE);
    model.addAttribute("no", no);

    return "contents/list_by_categoryno_search_paging"; // /templates/contents/list_by_categoryno_search_paging.html
  }
  
  /**
   * 목록 + 검색 + 페이징 지원 + Grid
   * 검색하지 않는 경우
   * http://localhost:9094/contents/list_by_categoryno_grid?categoryno=2&word=&now_page=1
   * 검색하는 경우
   * http://localhost:9094/contents/list_by_categoryno_grid?categoryno=2&word=탐험&now_page=1
   * 
   * @param categoryno
   * @param word
   * @param now_page
   * @return
   */
  @GetMapping(value="/list_by_categoryno_grid")
  public String list_by_categoryno_search_paging_grid(HttpSession session, Model model, 
                                                    int categoryno, 
                                                    @RequestParam(name="word", defaultValue = "") String word,
                                                    @RequestParam(name="now_page", defaultValue="1") int now_page) {
    
    // 메뉴 가져오기
    ArrayList<CategoryVOMenu> menu = this.categoryProcess.menu();
    model.addAttribute("menu", menu);
    
    CategoryVO categoryVO = this.categoryProcess.read(categoryno);
    model.addAttribute("categoryVO", categoryVO);
  
    word = Tool.checkNull(word).trim();
   
    HashMap<String, Object> map = new HashMap<>();
    map.put("categoryno", categoryno);
    map.put("word", word);
    map.put("now_page", now_page);
   
    // 페이징 목록
    ArrayList<ContentsVO> list = this.contentsProc.list_by_categoryno_search_paging(map);
    model.addAttribute("list", list);
    
    // System.out.println("-> size: " + list.size());
    model.addAttribute("word", word);
    
    // 페이징 버튼 목록
    int search_count = this.contentsProc.list_by_categoryno_search_count(map); // 갯수 가져오기
    String paging = this.contentsProc.pagingBox(categoryno, 
                                                            now_page, 
                                                            word, 
                                                            "/contents/list_by_categoryno_grid", 
                                                            search_count, 
                                                            Contents.RECORD_PER_PAGE, 
                                                            Contents.PAGE_PER_BLOCK);
    
    model.addAttribute("paging", paging);
    model.addAttribute("now_page", now_page);
    model.addAttribute("search_count", search_count);
    
    // 일련 변호 생성: 레코드 갯수 - ((현재 페이지수 -1) * 페이지당 레코드 수)
    int no = search_count - ((now_page - 1) * Contents.RECORD_PER_PAGE);
    model.addAttribute("no", no);

    return "contents/list_by_categoryno_search_paging_grid"; // /templates/contents/list_by_categoryno_search_paging.html
  }

    
  /**
   * 조회
   * http://localhost:9094/contents/read?contentsno=17
   * @return
   */
  @GetMapping(value="/read")
  public String read(Model model, 
                          int contentsno,
                          String word,
                          int now_page) { // int categoryno = (int)request.getParameter("categoryno");
    ArrayList<CategoryVOMenu> menu = this.categoryProcess.menu();
    model.addAttribute("menu", menu);
    
    ContentsVO contentsVO = this.contentsProc.read(contentsno);
    
//    String title = contentsVO.getTitle();
//    String content = contentsVO.getContent();
//    
//    title = Tool.convertChar(title);  // 특수 문자 처리
//    content = Tool.convertChar(content); 
//    
//    contentsVO.setTitle(title);
//    contentsVO.setContent(content);  
    
    long size1 = contentsVO.getSize1();
    String size1_label = Tool.unit(size1);
    contentsVO.setSize1_label(size1_label);
    
    model.addAttribute("contentsVO", contentsVO);
    
    CategoryVO categoryVO = this.categoryProcess.read(contentsVO.getCategoryno());
    model.addAttribute("categoryVO", categoryVO);

    // 조회에서 화면 하단에 출력
    // ArrayList<ReplyVO> reply_list = this.replyProc.list_contents(contentsno);
    // mav.addObject("reply_list", reply_list);
    
    model.addAttribute("word", word);
    model.addAttribute("now_page", now_page);
    
    return "contents/read";
  }
  
  /**
   * 맵 등록/수정/삭제 폼
   * http://localhost:9094/contents/map?contentsno=1
   * @return
   */
  @GetMapping(value="/map" )
  public String map(Model model, 
                         int contentsno,
                         int now_page,
                         String word) {
    ArrayList<CategoryVOMenu> menu = this.categoryProcess.menu();
    model.addAttribute("menu", menu);
    
    ContentsVO contentsVO = this.contentsProc.read(contentsno); // map 정보 읽어 오기
    model.addAttribute("contentsVO", contentsVO); // request.setAttribute("contentsVO", contentsVO);

    CategoryVO categoryVO = this.categoryProcess.read(contentsVO.getCategoryno()); // 그룹 정보 읽기
    model.addAttribute("categoryVO", categoryVO);
    model.addAttribute("word", word);
    model.addAttribute("now_page", now_page);

    return "contents/map";        
  }
  
  /**
   * MAP 등록/수정/삭제 처리
   * http://localhost:9094/contents/map
   * @param contentsVO
   * @return
   */
  @PostMapping(value="/map")
  public String map_update(Model model,
                                    RedirectAttributes ra,
                                    int contentsno,
                                    int now_page,
                                    String word,
                                    String map) {
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("contentsno", contentsno);
    hashMap.put("map", map);
    
    this.contentsProc.map(hashMap);
    
    ra.addAttribute("contentsno", contentsno);
    ra.addAttribute("word", word);
    ra.addAttribute("now_page", now_page);
    
    // return "redirect:/contents/read?contentsno=" + contentsno;
    return "redirect:/contents/read";
  }
  
  /**
   * Youtube 등록/수정/삭제 폼
   * http://localhost:9094/contents/youtube?contentsno=1
   * @return
   */
  @GetMapping(value="/youtube" )
  public String youtube(Model model, 
                              int contentsno,
                              int now_page,
                              String word) {
    ArrayList<CategoryVOMenu> menu = this.categoryProcess.menu();
    model.addAttribute("menu", menu);
    
    ContentsVO contentsVO = this.contentsProc.read(contentsno); // map 정보 읽어 오기
    model.addAttribute("contentsVO", contentsVO); // request.setAttribute("contentsVO", contentsVO);

    CategoryVO categoryVO = this.categoryProcess.read(contentsVO.getCategoryno()); // 그룹 정보 읽기
    model.addAttribute("categoryVO", categoryVO);
    model.addAttribute("word", word); 
    model.addAttribute("now_page", now_page); 

    return "contents/youtube";        
  }
  
  /**
   * Youtube 등록/수정/삭제 처리
   * http://localhost:9094/contents/youtube
   * @param contentsVO
   * @return
   */
  @PostMapping(value="/youtube")
  public String youtube_update(Model model,
                                        RedirectAttributes ra,
                                        int contentsno,
                                        int now_page,
                                        String word,
                                        String youtube) {
    
    if (youtube.trim().length() > 0) {  // 삭제 중인지 확인, 삭제가 아니면 youtube 크기 변경
      youtube = Tool.youtubeResize(youtube, 640);  // youtube 영상의 크기를 width 기준 640 px로 변경
    }    
    
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("contentsno", contentsno);
    hashMap.put("youtube", youtube);
    
    this.contentsProc.youtube(hashMap);
    
    ra.addAttribute("contentsno", contentsno);
    ra.addAttribute("word", word); 
    ra.addAttribute("now_page", now_page); 
    
    // return "redirect:/contents/read?contentsno=" + contentsno;
    return "redirect:/contents/read"; 
  }
  
  /**
  * 수정 폼
  * http://localhost:9094/contents/update_text?contentsno=1
  * @return
  */
 @GetMapping(value="/update_text")
 public String update_text(HttpSession session,
                                 Model model,
                                 RedirectAttributes ra,
                                 int contentsno,
                                 String word,
                                 int now_page) {
   
   ArrayList<CategoryVOMenu> menu = this.categoryProcess.menu();
   model.addAttribute("menu", menu);
   model.addAttribute("word", word);
   model.addAttribute("now_page", now_page);

   if (this.memberProc.isMemberAdmin(session)) { // 관리자로 로그인한경우
     ContentsVO contentsVO = this.contentsProc.read(contentsno);
     model.addAttribute("contentsVO", contentsVO); // 글 수정
     model.addAttribute("word", word);
     model.addAttribute("now_page", now_page);
        
     CategoryVO categoryVO = this.categoryProcess.read(contentsVO.getCategoryno());
     model.addAttribute("categoryVO", categoryVO);
     
     return "contents/update_text";
     // String content = "장소:\n인원:\n준비물:\n비용:\n기타:\n";
     // mav.addObject("content", content);
     
   } else {
     ra.addAttribute("url", "/member/login_cookie_need"); // /templates/member/login_cookie_need.html
     return "redirect:/contents/msg"; // templates/contents/msg.html, @GetMapping(value="/msg")
   }
 }
 
 /**
  * 수정 처리
  * http://localhost:9094/contents/update_text?contentsno=1
  * @return
  */
 @PostMapping(value = "/update_text")
 public String update_text_proc(HttpSession session, 
                                 ContentsVO contentsVO,
                                 Model model,
                                 RedirectAttributes ra,
                                 String search_word, // contentsVO.word와 구분 필요
                                 int now_page) {
   
   // System.out.println("-> word: " + contentsVO.getWord());
   
   if (this.memberProc.isMemberAdmin(session)) { // 관리자 로그인 확인
     HashMap<String, Object> map = new HashMap<String, Object>();
     map.put("contentsno", contentsVO.getContentsno());
     map.put("passwd", contentsVO.getPasswd());

     if (this.contentsProc.password_check(map) == 1) { // 패스워드 일치
       this.contentsProc.update_text(contentsVO); // 글수정  
        
       // ra 객체 이용
       ra.addFlashAttribute("cnt", 1);
       ra.addAttribute("contentsno", contentsVO.getContentsno());
       ra.addAttribute("categoryno", contentsVO.getCategoryno());
       ra.addAttribute("word", search_word);
       ra.addAttribute("now_page", now_page);
       
       return "redirect:/contents/read"; // 페이지 자동 이동, @GetMapping(value="/read")
     } else { // 패스워드 불일치
       ra.addFlashAttribute("code", "passwd_fail");
       ra.addFlashAttribute("cnt", 0);
       ra.addAttribute("url", "/contents/msg"); // msg.html, redirect parameter 적용
       return "redirect:/contents/msg";  // @GetMapping(value="/msg")
     }
   } else { // 정상적인 로그인이 아닌 경우 로그인 유도
     ra.addFlashAttribute("cnt", 0);
     ra.addAttribute("url", "/member/login_cookie_need"); // /templates/member/login_cookie_need.html
     return "redirect:/contents/msg";  //  @GetMapping(value="/msg"), redirct: 데이터 전달이 안됨. 초기화되면서 해당 경로로 이동된다고 생각.
   }
 }
 
 /**
  * 파일 수정 폼
  * http://localhost:9094/contents/update_file?contentsno=1
  * @return
  */
 @GetMapping(value = "/update_file")
 public String update_file(HttpSession session,
                                 Model model,
                                 RedirectAttributes ra,
                                 int contentsno,
                                 String word,
                                 int now_page) {
   
   ArrayList<CategoryVOMenu> menu = this.categoryProcess.menu();
   model.addAttribute("menu", menu);
   model.addAttribute("word", word);
   model.addAttribute("now_page", now_page);
   
   ContentsVO contentsVO = this.contentsProc.read(contentsno);
   model.addAttribute("contentsVO", contentsVO);
   
   CategoryVO categoryVO = this.categoryProcess.read(contentsVO.getCategoryno());
   model.addAttribute("categoryVO", categoryVO);
   
   return "update_file"; // /templates/contents/update_file.html
 }
 
 /**
  * 파일 수정 처리 http://localhost:9094/contents/update_file
  * @return
  */
 @PostMapping(value = "/update_file")
 public String update_file(HttpSession session,
                                 Model model,
                                 RedirectAttributes ra,
                                 ContentsVO contentsVO,
                                 String word,
                                 int now_page) {

   ArrayList<CategoryVOMenu> menu = this.categoryProcess.menu();
   model.addAttribute("menu", menu);
   model.addAttribute("word", word);
   model.addAttribute("now_page", now_page);
   
   if (this.memberProc.isMemberAdmin(session)) {
     // 삭제할 파일 정보를 읽어옴, 기존에 등록된 레코드 저장용
     ContentsVO contentsVO_old = contentsProc.read(contentsVO.getContentsno());
     
     // -------------------------------------------------------------------
     // 파일 삭제 시작
     // -------------------------------------------------------------------
     String file1saved = contentsVO_old.getFile1saved();  // 실제 저장된 파일명
     String thumb1 = contentsVO_old.getThumb1();       // 실제 저장된 preview 이미지 파일명
     long size1 = 0;
        
     String upDir =  Contents.getUploadDir(); // C:/kd/deploy/resort_v4sbm3c/contents/storage/
     
     Tool.deleteFile(upDir, file1saved);  // 실제 저장된 파일삭제
     Tool.deleteFile(upDir, thumb1);     // preview 이미지 삭제
     // -------------------------------------------------------------------
     // 파일 삭제 종료
     // -------------------------------------------------------------------
         
     // -------------------------------------------------------------------
     // 파일 전송 시작
     // -------------------------------------------------------------------
     String file1 = "";          // 원본 파일명 image

     // 전송 파일이 없어도 file1MF 객체가 생성됨.
     // <input type='file' class="form-control" name='file1MF' id='file1MF' 
     //           value='' placeholder="파일 선택">
     MultipartFile mf = contentsVO.getFile1MF();
         
     file1 = mf.getOriginalFilename(); // 원본 파일명
     size1 = mf.getSize();  // 파일 크기
         
     if (size1 > 0) { // 폼에서 새롭게 올리는 파일이 있는지 파일 크기로 체크 ★
       // 파일 저장 후 업로드된 파일명이 리턴됨, spring.jsp, spring_1.jpg...
       file1saved = Upload.saveFileSpring(mf, upDir); 
       
       if (Tool.isImage(file1saved)) { // 이미지인지 검사
         // thumb 이미지 생성후 파일명 리턴됨, width: 250, height: 200
         thumb1 = Tool.preview(upDir, file1saved, 250, 200); 
       }
       
     } else { // 파일이 삭제만 되고 새로 올리지 않는 경우
       file1="";
       file1saved="";
       thumb1="";
       size1=0;
     }
         
     contentsVO.setFile1(file1);
     contentsVO.setFile1saved(file1saved);
     contentsVO.setThumb1(thumb1);
     contentsVO.setSize1(size1);
     // -------------------------------------------------------------------
     // 파일 전송 코드 종료
     // -------------------------------------------------------------------
         
     this.contentsProc.update_file(contentsVO); // Oracle 처리

     ra.addAttribute("word", word);
     ra.addAttribute("now_page", now_page);
     ra.addAttribute("contentsno", contentsVO.getContentsno());
     ra.addAttribute("categoryno", contentsVO.getCategoryno());
     
     return "redirect:/contents/read"; // templates/contents/read.html
   } else {
     ra.addAttribute("url", "/member/login_cookie_need");
     return "redirect:/contents/msg"; // GET
   }
 }
 
 /**
  * 파일 삭제 폼
  * http://localhost:9094/contents/delete?contentsno=1
  * @return
  */
 @GetMapping(value = "/delete")
 public String delete(HttpSession session, 
                                       Model model,
                                       RedirectAttributes ra,
                                       int contentsno,
                                       String word,
                                       int now_page) {
   
   ArrayList<CategoryVOMenu> menu = this.categoryProcess.menu();
   model.addAttribute("menu", menu);
   
   if (memberProc.isMemberAdmin(session)) { // 관리자로 로그인한경우
     ContentsVO contentsVO = this.contentsProc.read(contentsno);
     model.addAttribute("contentsVO", contentsVO);
     model.addAttribute("word", word);
     model.addAttribute("now_page", now_page);
     
     CategoryVO categoryVO = this.categoryProcess.read(contentsVO.getCategoryno());
     model.addAttribute("categoryVO", categoryVO);
     
     
     return "/contents/delete";
   } else {
     ra.addAttribute("url", "/member/login_cookie_need");
     return "redirect:/contents/msg"; 
   }
 }
 
 /**
  * 삭제 처리 http://localhost:9094/contents/delete
  * @return
  */
 @PostMapping(value = "/delete")
 public String delete(Model model,
                                       RedirectAttributes ra,
                                       int contentsno,
                                       int categoryno,
                                       String word,
                                       int now_page) {
   
   // -------------------------------------------------------------------
   // 파일 삭제 시작
   // -------------------------------------------------------------------
   // 삭제할 파일 정보를 읽어옴.
   ContentsVO contentsVO_read = contentsProc.read(contentsno);
       
   String file1saved = contentsVO_read.getFile1saved();
   String thumb1 = contentsVO_read.getThumb1();
   
   String uploadDir = Contents.getUploadDir();
   Tool.deleteFile(uploadDir, file1saved);  // 실제 저장된 파일삭제
   Tool.deleteFile(uploadDir, thumb1);     // preview 이미지 삭제
   // -------------------------------------------------------------------
   // 파일 삭제 종료
   // -------------------------------------------------------------------
       
   this.contentsProc.delete(contentsno); // DBMS 삭제
   
   this.categoryProcess.cnt_minus(contentsVO_read.getCategoryno()); // 관련 글 수 감소
       
   // -------------------------------------------------------------------------------------
   // 마지막 페이지의 마지막 레코드 삭제시의 페이지 번호 -1 처리
   // -------------------------------------------------------------------------------------    
   // 마지막 페이지의 마지막 10번째 레코드를 삭제후
   // 하나의 페이지가 3개의 레코드로 구성되는 경우 현재 9개의 레코드가 남아 있으면
   // 페이지수를 4 -> 3으로 감소 시켜야함, 마지막 페이지의 마지막 레코드 삭제시 나머지는 0 발생
   
   HashMap<String, Object> map = new HashMap<String, Object>();
   map.put("categoryno", categoryno);
   map.put("word", word);
   
   if (contentsProc.list_by_categoryno_search_count(map) % Contents.RECORD_PER_PAGE == 0) {
     now_page = now_page - 1; // 삭제시 DBMS는 바로 적용되나 크롬은 새로고침등의 필요로 단계가 작동 해야함.
     if (now_page < 1) {
       now_page = 1; // 시작 페이지
     }
   }
   // -------------------------------------------------------------------------------------

   ra.addAttribute("categoryno", categoryno);
   ra.addAttribute("word", word);
   ra.addAttribute("now_page", now_page);
   
   return "redirect:/contents/list_by_categoryno"; 
 }   
  
}


