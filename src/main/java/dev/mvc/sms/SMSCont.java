package dev.mvc.sms;

import java.util.ArrayList;
import java.util.Random;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.category.CategoryVO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@RequestMapping("/category")
@Controller
public class SMSCont {
  public SMSCont() {
    System.out.println("-> SMSCont created.");
  }
  
  // http://localhost:9094/sms/form
  /**
  * 사용자의 전화번호 입력 화면
  * @return
  */
  @GetMapping(value="/sms/{form}")
  public String form(Model model) {

  return "/sms/{form}";
  }
  
  //http://localhost:9094/sms/proc.do
  /**
 * 사용자에게 인증 번호를 생성하여 전송
 * @param session
 * @param request
 * @return
 */
  @RequestMapping(value = {"/sms/proc.do"}, method=RequestMethod.POST)
  public ModelAndView proc(HttpSession session, HttpServletRequest request) {
    ModelAndView mav = new ModelAndView();
    
    // ------------------------------------------------------------------------------------------------------
    // 0 ~ 9, 번호 6자리 생성
    // ------------------------------------------------------------------------------------------------------
    String auth_no = "";
    Random random = new Random();
    for (int i=0; i<= 5; i++) {
      auth_no = auth_no + random.nextInt(10); // 0 ~ 9, 번호 6자리 생성
    }
    session.setAttribute("auth_no", auth_no); // 생성된 번호를 비교를위하여 session 에 저장
    //    System.out.println(auth_no);   
    // ------------------------------------------------------------------------------------------------------
    
    System.out.println("-> IP:" + request.getRemoteAddr()); // 접속자의 IP 수집
    
    // 번호, 전화 번호, ip, auth_no, 날짜 -> SMS Oracle table 등록, 문자 전송 내역 관리 목적으로 저장(필수 아니나 권장)
    
    String msg = "[www.resort.co.kr] [" + auth_no + "]을 인증번호란에 입력해주세요.";
    System.out.print(msg);
    
    mav.addObject("msg", msg); // request.setAttribute("msg")
    mav.setViewName("/sms/proc");  // /WEB-INF/views/sms/proc.jsp
    
    return mav;
  }
}
