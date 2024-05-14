package dev.mvc.sms;

import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/sms")
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
    @GetMapping(value="/form")
    public String form() {
        return "sms/form";
    }

    // http://localhost:9094/sms/proc
    /**
     * 사용자에게 인증 번호를 생성하여 전송
     * @param session
     * @param request
     * @return
     */
    @PostMapping(value="/proc")
    public String proc(HttpSession session, 
                            HttpServletRequest request) {
        // ------------------------------------------------------------------------------------------------------
        // 0 ~ 9, 번호 6자리 생성
        // ------------------------------------------------------------------------------------------------------
        String auth_no = "";
        Random random = new Random();
        for (int i = 0; i <= 5; i++) {
            auth_no = auth_no + random.nextInt(10); // 0 ~ 9, 번호 6자리 생성
        }
        session.setAttribute("auth_no", auth_no); // 생성된 번호를 비교를위하여 session 에 저장
        //    System.out.println(auth_no);   
        // ------------------------------------------------------------------------------------------------------

        System.out.println("-> IP:" + request.getRemoteAddr()); // 접속자의 IP 수집

        // 번호, 전화 번호, ip, auth_no, 날짜 -> SMS Oracle table 등록, 문자 전송 내역 관리 목적으로 저장(필수 아니나 권장)

        String msg = "[www.resort.co.kr] [" + auth_no + "]을 인증번호란에 입력해주세요.";
        System.out.print(msg);

        request.setAttribute("msg", msg);

        return "sms/proc";
    }

    // http://localhost:9094/sms/proc_next
    /**
     * 사용자가 수신받은 인증번호 입력 화면
     * @return
     */
    @GetMapping(value="/proc_next")
    public String proc_next() {
        return "sms/proc_next"; 
    }

    // http://localhost:9094/sms/confirm
    /**
     * 문자로 전송된 번호와 사용자가 입력한 번호를 비교한 결과 화면
     * @param session 사용자당 할당된 서버의 메모리
     * @param auth_no 사용자가 입력한 번호
     * @param request
     * @return
     */
    @PostMapping(value="/confirm")
    public String confirm(HttpSession session, 
                                String auth_no, 
                                HttpServletRequest request) {
        String session_auth_no = (String) session.getAttribute("auth_no"); // 사용자에게 전송된 번호 session에서 꺼냄

        String msg = "";

        if (session_auth_no.equals(auth_no)) {
            msg = "ID공개 페이지나 패스워드 분실시 새로운 패스워드 입력 화면으로 이동합니다.<br><br>";
            msg += "패스워드 수정 화면등 출력";
        } else {
            msg = "입력된 번호가 일치하지않습니다. 다시 인증 번호를 요청해주세요.";
            msg += "<br><br><a href='./form.do'>인증번호 재요청</a>"; 
        }

        request.setAttribute("msg", msg);

        return "sms/confirm";
    }  
}
