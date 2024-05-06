package dev.mvc.category;

import java.util.ArrayList;
import java.util.Map;

public interface CategoryDAOInterface {
  /**
   * 등록
   * insert id="create" parameterType="dev.mvc.category.CategoryVO"
   * @param cateVO
   * @return 등록한 레코드 갯수
   */
  public int create(CategoryVO categoryVO);
  
  /**
   * 전체 목록
   * select id="list_all" resultType="dev.mvc.category.CategoryVO"     
   * @return 레코드 목록
   */
  public ArrayList<CategoryVO> list_all();
  
  /**
   * 조회
   * select id="read" resultType="dev.mvc.category.CategoryVO" parameterType="int"
   * @param categoryno
   * @return
   */
  public CategoryVO read(int categoryno);
  
  /**
   * 수정
   * update id="update" parameterType="dev.mvc.category.CategoryVO"    
   * @param categoryVO
   * @return 수정된 레코드 갯수
   */
  public int update(CategoryVO categoryVO);
  
  /**
   * delete
   * delete id="delete" parameterType="Integer"
   * @param categoryno
   * @return
   */
  public int delete(int categoryno);

  /**
   * 우선 순위 높임, 10 등 -> 1 등
   * update id="update_seqno_forward" parameterType="Integer"
   * @param categoryno
   * @return 수정한 레코드 갯수
   * */
  public int update_seqno_forward(int categoryno);
  
  /**
   * 우선 순위 낮춤, 1 등 -> 10 등
   * update id="update_seqno_backward" parameterType="Integer"
   * @param categoryno
   * @return 수정한 레코드 갯수
   * */
  public int update_seqno_backward(int categoryno);
  
  /**
   * 카테고리 공개 설정
   * update id="update_visible_y" parameterType="int"
   * @param categoryno
   * @return
   */
  public int update_visible_y(int categoryno);

  /**
   * 카테고리 비공개 설정
   * update id="update_visible_n" parameterType="int"
   * @param categoryno
   * @return
   */
  public int update_visible_n(int categoryno);
    
  /**
   * 회원/비회원에게 공개할 중분류 목록 
   * select id="list_all_y" resultType="dev.mvc.category.CategoryVO"     
   * @return
   */
  public ArrayList<CategoryVO> list_all_name_y();
  
  /**
   * 회원/비회원에게 공개할 소분류 목록 
   * select id="list_all_namesub_y" resultType="dev.mvc.category.CategoryVO" parameterType="String"
   * @return
   */
  public ArrayList<CategoryVO> list_all_namesub_y(String name);    
  
  /**
   * 관리자용 검색 목록
   * select id="list_search" resultType="dev.mvc.category.CategoryVO" parameterType="String"
   * @param map
   * @return 조회한 레코드 목록
   */
  public ArrayList<CategoryVO> list_search(String word);    
      
  /**
   * 검색목록 페이징
   * select id="list_search_paging" resultType="dev.mvc.category.CategoryVO" parameterType="Map"
   * @param map
   * @return 조회한 레코드 목록
   */
  public ArrayList<CategoryVO> list_search_paging(Map<String, Object> map);
  
  /**
   * 검색된 레코드 수
   * @param word
   * @return
   */
  public int list_search_count(String word);
}

