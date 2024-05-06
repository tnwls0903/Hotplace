package dev.mvc.resort_v1sbm3c;

import java.util.HashMap;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.test.context.SpringBootTest;

import dev.mvc.category.CategoryProcessInterface;
import dev.mvc.contents.ContentsProcInter;
import dev.mvc.member.MemberProcInter;

@SpringBootTest
public class ContentsTest {
  @Autowired
  @Qualifier("dev.mvc.member.MemberProc") // "dev.mvc.member.MemberProc"라고 명명된 클래스
  private MemberProcInter memberProc; // MemberProcInter를 구현한 memberProc 클래스의 객체를 자동으로 생성하여 할당

  @Autowired
  @Qualifier("dev.mvc.category.CategoryProcess")  // @Component("dev.mvc.category.CategoryProcess")
  private CategoryProcessInterface categoryProcess;
  
  @Autowired
  @Qualifier("dev.mvc.contents.ContentsProc") // @Component("dev.mvc.contents.ContentsProc")
  private ContentsProcInter contentsProc;
  
  @Test
  public void testRead() {
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("contentsno", 1);
    hashMap.put("passwd", "fS/kjO+fuEKk06Zl7VYMhg==");
    
    System.out.println("-> cnt: " + this.contentsProc.password_check(hashMap));
    
  }
}
