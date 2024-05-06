package dev.mvc.resort_v1sbm3c;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import dev.mvc.category.CategoryProcessInterface;
import dev.mvc.category.CategoryVO;
import dev.mvc.category.CategoryVOMenu;
import dev.mvc.tool.Security;

@Controller
public class HomeCont {
  @Autowired
  @Qualifier("dev.mvc.category.CategoryProcess")
  private CategoryProcessInterface categoryProcess;
  
//  @Autowired
//  private Security security;
  
  public HomeCont() {
    System.out.println("-> HomeCont created.");
  }
  
  @GetMapping(value="/") // http://localhost:9094
  public String home(Model model) { // 파일명 return
//    if (this.security != null) {
//      System.out.println("-> 객체 고유 코드: " + security.hashCode());
//      System.out.println(security.aesEncode("1234"));
//    }
    
    ArrayList<CategoryVOMenu> menu = this.categoryProcess.menu();
    model.addAttribute("menu", menu);
    
    return "index"; // /templates/index.html  
  }
  
}






