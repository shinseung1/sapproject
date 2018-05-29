package dev.mvc.blog;

import java.util.HashMap;
import java.util.List;

public interface BlogDAOInter {
  /**
   * 등록
   * <xmp>
   * <insert id="create" parameterType="BlogVO">
   * </xmp>
   * @param blogVO
   * @return
   */
  public int create(BlogVO blogVO);
  
  // <select id="list_all_category" resultType="BlogVO">
  public List<BlogVO> list_all_category(); 
  
  /**
   * <xmp>
   * <select id="list_by_categoryno" resultType="BlogVO" parameterType="int">
   * </xmp>
   * @param categoryno
   * @return
   */
  public List<BlogVO> list_by_categoryno(int categoryno); 
  
  /**
   * 전체 레코드 갯수
   * <select id="total_count" resultType="int"> 
   * @return
   */
  public int total_count();  
 
  // <select id="read" resultType="BlogVO" parameterType="int">
  public BlogVO read(int blogno);
  
  // <update id="update" parameterType="BlogVO">
  public int update(BlogVO blogVO);
  
  // <delete id="delete" parameterType="int">
  public int delete(int blogno);
  
  /**
   * <select id="list_by_categoryno" resultType="BlogVO" parameterType="HashMap">
   * @param categoryno
   * @return
   */
  public List<BlogVO> list_by_categoryno(HashMap hashMap);

  /**
   * category별 검색된 레코드 갯수
   * <select id="search_count" resultType="int" parameterType="BlogVO">
   * @return
   */
  public int search_count(HashMap hashMap);  
 
  /**
   * 신규 답변을 최우선으로 출력하기위한 답변 순서 조절
   * @param blogVO
   * @return
   */
  public int updateAnsnum(BlogVO blogVO);
  
  /**
   * 답변
   * @param blogVO
   * @return
   */
  public int reply(BlogVO blogVO);
  
  
}



