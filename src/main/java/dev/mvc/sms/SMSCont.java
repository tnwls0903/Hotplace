package dev.mvc.sms;

import java.util.ArrayList;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import dev.mvc.category.CategoryVO;
import dev.mvc.category.CategoryVOMenu;
import jakarta.validation.Valid;

@RequestMapping("/category")
@Controller
public class SMSCont {
  public SMSCont() {
    System.out.println("-> SMSCont created.");
  }
  
  @GetMapping(value="/sms/{form}")
  public String form(Model model, @Valid CategoryVO categoryVO, BindingResult bindingResult) {
    
    return "/sms/{form}";
  }
}
