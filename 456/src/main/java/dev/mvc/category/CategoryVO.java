package dev.mvc.category;

/* 
  categoryno      NUMBER(7)                                 NOT NULL,
  categrpno        NUMBER(10)                               NOT NULL ,
  title                 VARCHAR2(50)                            NOT NULL,
  seqno              NUMBER(3)        DEFAULT 1         NOT NULL,
  visible              CHAR(1)            DEFAULT 'Y'        NOT NULL,
  ids                   VARCHAR2(100) DEFAULT 'admin' NOT NULL,
  cnt                   NUMBER(6)       DEFAULT 0          NOT NULL, 
  rdate               DATE                 NOT NULL,
 */
public class CategoryVO {
  private int categoryno;
  private int categrpno;
  private String title;
  private int seqno;
  private String visible;
  private String ids;
  private int cnt;
  private String rdate;
  
  public CategoryVO() {

  }

  public int getCategoryno() {
    return categoryno;
  }

  public void setCategoryno(int categoryno) {
    this.categoryno = categoryno;
  }

  public int getCategrpno() {
    return categrpno;
  }

  public void setCategrpno(int categrpno) {
    this.categrpno = categrpno;
  }

  public String getTitle() {
    return title;
  }

  public void setTitle(String title) {
    this.title = title;
  }

  public int getSeqno() {
    return seqno;
  }

  public void setSeqno(int seqno) {
    this.seqno = seqno;
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
  
    
}
 