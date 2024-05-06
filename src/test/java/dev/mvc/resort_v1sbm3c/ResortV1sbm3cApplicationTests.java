package dev.mvc.resort_v1sbm3c;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.test.context.SpringBootTest;

import dev.mvc.category.CategoryDAOInterface;
import dev.mvc.category.CategoryProcessInterface;
import dev.mvc.category.CategoryVO;

@SpringBootTest
class ResortV1sbm3cApplicationTests {
  @Autowired // CateDAOInter를 구현한 클래스의 객체를 생성하여 cateDAO 변수에 할당
  private CategoryDAOInterface categoryDAO;

  @Autowired // CateProcInter를 구현한 클래스의 객체를 생성하여 cateProc 변수에 할당
  @Qualifier("dev.mvc.category.CategoryProcess")
  private CategoryProcessInterface categoryProcess;

	@Test
	void contextLoads() {
	}
	
//	@Test
//	public void testCreate() {
//    CategoryVO categoryVO = new CategoryVO();	 
//    categoryVO.setName("서울");
//    categoryVO.setNamesub("강남");
//    
//    int cnt = this.categoryDAO.create(categoryVO);
//    System.out.println("-> cnt: " + cnt);
//	}

//	 @Test
//	  public void testCreate() {
//	    CategoryVO categoryVO = new CategoryVO();  
//	    categoryVO.setName("서울");
//	    categoryVO.setNamesub("건대");
//	    
//	    int cnt = this.categoryProcess.create(categoryVO);
//	    System.out.println("-> cnt: " + cnt);
//	  }
	 
//	 @Test
//	 public void testList_all() {
//	   ArrayList<CategoryVO> list = this.categoryDAO.list_all();
//	   for (CategoryVO categoryVO : list) {
//	     System.out.println(categoryVO.getName() + " - " + categoryVO.getNamesub());
//	   }	   
//	 }

//  @Test
//  public void testList_all() {
//    ArrayList<CategoryVO> list = this.categoryProcess.list_all();
//    for (CategoryVO categoryVO : list) {
//      System.out.println(categoryVO.getName() + " - " + categoryVO.getNamesub());
//    }     
//  }
	
	@Test
	public void Hangul() {
//	  String word = URLEncoder.encode("서울");
//	  System.out.println("원본: %EC%98%A4%EB%B2%84%EB%A0%8C%EB%94%A9");
//	  System.out.println("변환: " + word);
//	  
//	  word = URLDecoder.decode("%EC%98%A4%EB%B2%84%EB%A0%8C%EB%94%A9"); 
//	  System.out.println("복원: " + word);

//	  // JDK 10+, VSCode 사용
//	  String word = URLEncoder.encode("서울", StandardCharsets.UTF_8);
//	  System.out.println("원본: %EC%98%A4%EB%B2%84%EB%A0%8C%EB%94%A9");
//	  System.out.println("변환: " + word);
//	    
//	  word = URLDecoder.decode("%EC%98%A4%EB%B2%84%EB%A0%8C%EB%94%A9", StandardCharsets.UTF_8); 
//	  System.out.println("복원: " + word);
	}
	
	@Test
  public void testcount() {
    int cnt= this.categoryProcess.list_search_count("서울");
    System.out.println("-> cnt: " + cnt);
  }
	
}







