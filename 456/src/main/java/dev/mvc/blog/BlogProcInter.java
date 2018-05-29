package dev.mvc.blog;

import java.util.HashMap;
import java.util.List;

public interface BlogProcInter {
  /**
   * 등록
   * <insert id="create" parameterType="BlogVO">
   * @param blogVO
   * @return
   */
  public int create(BlogVO blogVO);

  // <select id="list_all_category" resultType="BlogVO">
  public List<BlogVO> list_all_category(); 
  
  /**
   * <select id="list_by_categoryno" resultType="BlogVO" parameterType="int">
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
   * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
   * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
   *
   * @param categoryno 카테고리번호 
   * @param search_count 검색(전체) 레코드수 
   * @param nowPage     현재 페이지
   * @param word_find 검색어
   * @return 페이징 생성 문자열
   */ 
  public String paging(int categoryno, int search_count, int nowPage, String word_find); 
  
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
 



