package dev.mvc.categrp;

public class CategrpVO {
  /**  ī�װ� �̸� */
  private String name;
  /** ī�װ� ��ȣ */
  private int categrpno;
  /** ��� ���� */
  private int seqno;
  /** ��� ��� */
  private String visible;
  /** ����� */
  private String rdate;

  public String getName() {
    return name;
  }

  public void setName(String name) {
    // System.out.println("--> CategrpVO setName(\""+name+"\") ȣ���.");
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

  public String getVisible() {
    return visible;
  }

  public void setVisible(String visible) {
    this.visible = visible;
  }

  public String getRdate() {
    return rdate;
  }

  public void setRdate(String rdate) {
    this.rdate = rdate;
  }

  
} 