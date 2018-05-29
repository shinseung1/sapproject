package dev.mvc.category;

public class Categrp_CategoryVO {
  // categrp table
  private String name;
  private int categrpno;
  private int seqno;
  
  // category table
  private int categoryno;
  private String title;
  private int category_seqno; // JOIN 시만 사용, seqno 컬럼과 대응
  private String visible;
  private String ids;
  private int cnt;
  private String rdate;
  
  public String getName() {
    return name;
  }
  public void setName(String name) {
    this.name = name;
  }
  public int getCategrpno() {
    return categrpno;
  }
  public void setCategrpno(int categrpno) {
    this.categrpno = categrpno;
  }
  public int getSeqno() {
    return seqno;
  }
  public void setSeqno(int seqno) {
    this.seqno = seqno;
  }
  public int getCategoryno() {
    return categoryno;
  }
  public void setCategoryno(int categoryno) {
    this.categoryno = categoryno;
  }
  public String getTitle() {
    return title;
  }
  public void setTitle(String title) {
    this.title = title;
  }
  public String getVisible() {
    return visible;
  }
  public void setVisible(String visible) {
    this.visible = visible;
  }
  public String getIds() {
    return ids;
  }
  public void setIds(String ids) {
    this.ids = ids;
  }
  public int getCnt() {
    return cnt;
  }
  public void setCnt(int cnt) {
    this.cnt = cnt;
  }
  public String getRdate() {
    return rdate;
  }
  public void setRdate(String rdate) {
    this.rdate = rdate;
  }
  public int getCategory_seqno() {
    return category_seqno;
  }
  public void setCategory_seqno(int category_seqno) {
    this.category_seqno = category_seqno;
  }

  
}