package dev.mvc.category;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import dev.mvc.member.MemberProc;
import dev.mvc.member.MemberProcInter;
import dev.mvc.tool.Tool;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@RequestMapping("/category")
@Controller
public class CategoryController {
  @Autowired
  @Qualifier("dev.mvc.category.CategoryProcess")
  private CategoryProcessInterface categoryProcess;
  
  @Autowired
  @Qualifier("dev.mvc.member.MemberProc")  // @Service("dev.mvc.member.MemberProc")
  private MemberProcInter memberProc;
  
  /** 페이지당 출력할 레코드 갯수, nowPage는 1부터 시작 */
  public int record_per_page = 10;

  /** 블럭당 페이지 수, 하나의 블럭은 10개의 페이지로 구성됨 */
  public int page_per_block = 10;
  
  public CategoryController() {
    System.out.println("-> CategoryController created.");  
  }
 
  
  /**
   * create 폼 데이터 처리
   * http://localhost:9094/category/list_search
   * @param model
   * @param categoryVO
   * @param bindingResult
   * @return
   */
  @PostMapping(value="/create") // http://localhost:9094/cate/create
  public String create(Model model, @Valid CategoryVO categoryVO, BindingResult bindingResult, 
      @RequestParam(name="word", defaultValue="") String word,
      @RequestParam(name="now_page", defaultValue="1") int now_page) {
    
    ArrayList<CategoryVOMenu> menu = this.categoryProcess.menu();
    model.addAttribute("menu", menu);
    
    if (bindingResult.hasErrors()) {
      // 페이징 목록
      ArrayList<CategoryVO> list = this.categoryProcess.list_search_paging(word, now_page, this.record_per_page);    
      model.addAttribute("list", list);
      
      // 페이징 버튼 목록
      int search_count = this.categoryProcess.list_search_count(word);
      
      // 일련 변호 생성: 레코드 갯수 - ((현재 페이지수 -1) * 페이지당 레코드 수)
      int no = search_count - ((now_page - 1) * this.record_per_page);
      model.addAttribute("no", no);
      
      String paging = this.categoryProcess.pagingBox(now_page, 
          word, "category/list_search", search_count, this.record_per_page, this.page_per_block);
      model.addAttribute("paging", paging);
      model.addAttribute("now_page", now_page);
      
      return "category/list_search";  // /templates/category/list_search.html
    }
    
    int cnt = this.categoryProcess.create(categoryVO);
    System.out.println("-> cnt: " + cnt);

    model.addAttribute("cnt", cnt);
    if (cnt == 1) { // 등록 성공
//      model.addAttribute("code", "create_success");
//      model.addAttribute("name", categoryVO.getName());
//      model.addAttribute("namesub", categoryVO.getNamesub());
      
      return "redirect:/category/list_search"; // /category/list_search.html
      
    } else { // 실패
      model.addAttribute("code", "create_fail");
      return "category/msg"; // /templates/category/msg.html
    }
  }
  
//  /**
//   * 등록폼 + 목록
//   * @param model
//   * @param categoryVO
//   * @return
//   */
//  @GetMapping(value="/list_search")
//  public String list_all(Model model, CategoryVO categoryVO) {
//    // categoryVO.setNamesub("-"); // 폼 초기값 설정
//    
//    ArrayList<CategoryVOMenu> menu = this.categoryProcess.menu();
//    model.addAttribute("menu", menu);
//    
//    ArrayList<CategoryVO> list = this.categoryProcess.list_search();
//    model.addAttribute("list", list);
//    
//    return "category/list_search"; // /category/list_search.html
//  }

  /**
   * 조회 + 목록
   * @param model
   * @param cateno 조회할 카테고리 번호
   * @return
   */
  @GetMapping(value="/read/{categoryno}")
  public String read(Model model, 
                            @PathVariable("categoryno") Integer categoryno, 
                            @RequestParam(name="word", defaultValue = "") String word,
                            @RequestParam(name="now_page", defaultValue="1") int now_page) {
    
    
    ArrayList<CategoryVOMenu> menu = this.categoryProcess.menu();
    model.addAttribute("menu", menu);
    
    CategoryVO categoryVO = this.categoryProcess.read(categoryno);
    model.addAttribute("categoryVO", categoryVO);
    
    // 페이징 목록
    ArrayList<CategoryVO> list = this.categoryProcess.list_search_paging(word, now_page, this.record_per_page);    
    model.addAttribute("list", list);
    
    // 페이징 버튼 목록
    int search_count = this.categoryProcess.list_search_count(word);
    String paging = this.categoryProcess.pagingBox(now_page, 
        word, "/category/list_search", search_count, this.record_per_page, this.page_per_block);
    model.addAttribute("paging", paging);
    model.addAttribute("now_page", now_page);
    
    model.addAttribute("word", word);
    
    // 일련 변호 생성: 레코드 갯수 - ((현재 페이지수 -1) * 페이지당 레코드 수)
    int no = search_count - ((now_page - 1) * this.record_per_page);
    model.addAttribute("no", no);
    
    return "category/read";  // /templates/category/read.html\
  }
  
  /**
   * 수정폼
   * @param model
   * @param categoryno 조회할 카테고리 번호
   * @return
   */
  @GetMapping(value="/update/{categoryno}")
  public String update(HttpSession session,
                                Model model, 
                                @PathVariable("categoryno") Integer categoryno, 
                                @RequestParam(name="word", defaultValue = "") String word,
                                @RequestParam(name="now_page", defaultValue = "1") int now_page) {
    
    if (this.memberProc.isMemberAdmin(session)) {
      ArrayList<CategoryVOMenu> menu = this.categoryProcess.menu();
      model.addAttribute("menu", menu);
      
      CategoryVO categoryVO = this.categoryProcess.read(categoryno);
      model.addAttribute("categoryVO", categoryVO);
      
      // 페이징 목록
      ArrayList<CategoryVO> list = this.categoryProcess.list_search_paging(word, now_page, this.record_per_page);    
      model.addAttribute("list", list);
      
      // 페이징 버튼 목록
      int search_count = this.categoryProcess.list_search_count(word);
      String paging = this.categoryProcess.pagingBox(now_page, 
          word, "/category/list_search", search_count, this.record_per_page, this.page_per_block);
      model.addAttribute("paging", paging);
      model.addAttribute("now_page", now_page);
      
      model.addAttribute("word", word);
      
      // 일련 변호 생성: 레코드 갯수 - ((현재 페이지수 -1) * 페이지당 레코드 수)
      int no = search_count - ((now_page - 1) * this.record_per_page);
      model.addAttribute("no", no);
      
      return "category/update";  // /templates/category/update.html
    } else {
      return "redirect:/member/login_form_need";  // redirect
    }
  }
  
  /**
   * 수정 처리
   * @param model
   * @param categoryVO
   * @param bindingResult
   * @return
   */
  @PostMapping(value="/update") // http://localhost:9094/category/update
  public String update_process(HttpSession session,
                                            Model model, 
                                            @Valid CategoryVO categoryVO, BindingResult bindingResult, 
                                            @RequestParam(name="word", defaultValue = "") String word,
                                            @RequestParam(name="now_page", defaultValue="1") int now_page) {
    
    if (this.memberProc.isMemberAdmin(session)) {
      ArrayList<CategoryVOMenu> menu = this.categoryProcess.menu();
      model.addAttribute("menu", menu);
      
      if (bindingResult.hasErrors()) {
        // 페이징 목록
        ArrayList<CategoryVO> list = this.categoryProcess.list_search_paging(word, now_page, this.record_per_page);    
        model.addAttribute("list", list);
        
        // 페이징 버튼 목록
        int search_count = this.categoryProcess.list_search_count(word);
        String paging = this.categoryProcess.pagingBox(now_page, 
            word, "category/list_search", search_count, this.record_per_page, this.page_per_block);
        model.addAttribute("paging", paging);
        model.addAttribute("now_page", now_page);
        
        return "category/update";  // /templates/category/update.html
      }
      
      int cnt = this.categoryProcess.update(categoryVO);
//      System.out.println("-> cnt: " + cnt);

      model.addAttribute("cnt", cnt);
      if (cnt == 1) {
        return "redirect:/category/update/" + categoryVO.getCategoryno() + "?word=" + Tool.encode(word) + "&now_page=" + now_page;
      } else {
        model.addAttribute("code", "update_fail");
        return "cate/msg"; // /templates/category/msg.html
      }
    } else {
      return "redirect:/member/login_form_need";  // redirect
    }
  }
  
  /**
   * Delete form
   * http://localhost:9094/category/delete/1
   * @param model
   * @param categoryno Category number to delete.
   * @return
   */
  @GetMapping(value="/delete/{categoryno}")
  public String delete(HttpSession session, Model model, 
                               @PathVariable("categoryno") Integer categoryno, 
                               @RequestParam(name="word", defaultValue = "") String word,
                               @RequestParam(name="now_page", defaultValue = "1") int now_page) {
    
    if (this.memberProc.isMemberAdmin(session)) {
      ArrayList<CategoryVOMenu> menu = this.categoryProcess.menu();
      model.addAttribute("menu", menu);
      
      CategoryVO categoryVO = this.categoryProcess.read(categoryno);
      model.addAttribute("categoryVO", categoryVO);
      
      // 페이징 목록
      ArrayList<CategoryVO> list = this.categoryProcess.list_search_paging(word, now_page, this.record_per_page);    
      model.addAttribute("list", list);
      
      // 페이징 버튼 목록
      int search_count = this.categoryProcess.list_search_count(word);
      String paging = this.categoryProcess.pagingBox(now_page, 
          word, "/category/list_search", search_count, this.record_per_page, this.page_per_block);
      model.addAttribute("paging", paging);
      model.addAttribute("now_page", now_page);
      
      model.addAttribute("word", word);
      
      // 일련 변호 생성: 레코드 갯수 - ((현재 페이지수 -1) * 페이지당 레코드 수)
      int no = search_count - ((now_page - 1) * this.record_per_page);
      model.addAttribute("no", no);
      
      return "category/delete";  // /templates/category/delete.html
    } else {
      return "redirect:/member/login_form_need";  // redirect
    }   
  }
  
  /**
   * Delete process
   * @param model
   * @param categoryno 삭제할 레코드 번호
   * @param bindingResult
   * @return
   */
  @PostMapping(value="/delete")
  public String delete_process(Model model, Integer categoryno, 
                                           @RequestParam(name="word", defaultValue = "") String word,
                                           @RequestParam(name="now_page", defaultValue = "1") int now_page) {
    
    int cnt = this.categoryProcess.delete(categoryno); // 삭제
    // System.out.println("-> cnt: " + cnt);
    
    model.addAttribute("cnt", cnt);
    
    // ----------------------------------------------------------------------------------------------------------
    // 마지막 페이지에서 모든 레코드가 삭제되면 페이지수를 1 감소 시켜야함.
    int search_cnt = this.categoryProcess.list_search_count(word);
    if (search_cnt % this.record_per_page == 0) {
      now_page = now_page - 1;
      if (now_page < 1) {
        now_page = 1; // 최소 시작 페이지
      }
    }
    // ----------------------------------------------------------------------------------------------------------
    
    if (cnt == 1) {
      return "redirect:/category/list_search?word=" + Tool.encode(word) + "&now_page=" + now_page;
    } else {
      model.addAttribute("code", "delete_fail");
      return "category/msg"; // /templates/category/msg.html
    }
  }

  /**
   * 출력 순서 높임: seqno 10 -> 1
   * http://localhost:9094/category/update_seqno_forward/1
   * @param model
   * @param categoryno 조회할 카테고리 번호
   * @return
   */
  @GetMapping(value="/update_seqno_forward/{categoryno}")
  public String update_seqno_forward(Model model, 
                                                       @PathVariable("categoryno") Integer categoryno, 
                                                       @RequestParam(name="word", defaultValue = "") String word,
                                                       @RequestParam(name="now_page", defaultValue = "1") int now_page) {

    this.categoryProcess.update_seqno_forward(categoryno);
    
    return "redirect:/category/list_search?word=" + Tool.encode(word) + "&now_page=" + now_page;  // /templates/category/list_search.html
  }

  /**
   * 출력 순서 낮춤: seqno 1 -> 10
   * http://localhost:9094/category/update_seqno_backward/1
   * @param model
   * @param categoryno 조회할 카테고리 번호
   * @return
   */
  @GetMapping(value="/update_seqno_backward/{categoryno}")
  public String update_seqno_backward(Model model, 
                                                         @PathVariable("categoryno") Integer categoryno, 
                                                         @RequestParam(name="word", defaultValue = "") String word,
                                                         @RequestParam(name="now_page", defaultValue = "1") int now_page) {
   
    this.categoryProcess.update_seqno_backward(categoryno);
    
    return "redirect:/category/list_search?word=" + Tool.encode(word) + "&now_page=" + now_page;  // /templates/category/list_search.html
  }
  
  /**
   * 카테고리 공개 설정
   * http://localhost:9094/category/update_visible_y/1
   * @param model
   * @param categoryno 조회할 카테고리 번호
   * @return
   */
  @GetMapping(value="/update_visible_y/{categoryno}")
  public String update_visible_y(Model model, 
                                             @PathVariable("categoryno") Integer categoryno, 
                                             @RequestParam(name="word", defaultValue = "") String word) {

    this.categoryProcess.update_visible_y(categoryno);
    
    return "redirect:/category/list_search?word=" + Tool.encode(word);  // /templates/category/list_search.html
  }
  
  /**
   * 카테고리 비공개 설정
   * http://localhost:9094/category/update_visible_n/1
   * @param model
   * @param categoryno 조회할 카테고리 번호
   * @return
   */
  @GetMapping(value="/update_visible_n/{categoryno}")
  public String update_visible_n(Model model, 
                                             @PathVariable("categoryno") Integer categoryno, 
                                             @RequestParam(name="word", defaultValue = "") String word) {
    
    this.categoryProcess.update_visible_n(categoryno);
    
    return "redirect:/category/list_search?word=" + Tool.encode(word);  // /templates/category/list_search.html
  }

  /**
   * 등록폼 + 검색 목록
   * http://localhost:9094/category/list_search?word=서울  ← GET Form
   * http://localhost:9094/category/list_search/서울  ← @PathVariable
   * @param model
   * @param categoryVO
   * @param word 검색어
   * @param now_page 현재 페이지 번호
   * @return
   */
  @GetMapping(value="/list_search")
  public String list_search(HttpSession session, Model model, CategoryVO categoryVO, 
                                     String word, 
                                     @RequestParam(name="now_page", defaultValue="1") int now_page) {
    
    if (this.memberProc.isMemberAdmin(session)) {
      // categoryVO.setNamesub("-"); // 폼 초기값 설정
      word = Tool.checkNull(word).trim();
      // System.out.println("--> word: " + word);
      
      ArrayList<CategoryVOMenu> menu = this.categoryProcess.menu();
      model.addAttribute("menu", menu);
      
      // 페이징 목록
      ArrayList<CategoryVO> list = this.categoryProcess.list_search_paging(word, now_page, this.record_per_page);    
      model.addAttribute("list", list);
      
      // 페이징 버튼 목록
      int search_count = this.categoryProcess.list_search_count(word);
      String paging = this.categoryProcess.pagingBox(now_page, 
          word, "/category/list_search", search_count, this.record_per_page, this.page_per_block);
      model.addAttribute("paging", paging);
      model.addAttribute("now_page", now_page);
      
      model.addAttribute("word", word);
      
      // 일련 변호 생성: 레코드 갯수 - ((현재 페이지수 -1) * 페이지당 레코드 수)
      int no = search_count - ((now_page - 1) * this.record_per_page);
      model.addAttribute("no", no);
      
      return "category/list_search"; // /category/list_search.html
    } else {
      return "redirect:/member/login_form_need";  // redirect
    }
  }  
}

