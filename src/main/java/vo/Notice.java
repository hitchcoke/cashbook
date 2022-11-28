package vo;

public class Notice {
	private int noticeNo;
	private String noticeMemo;
	
	private String createdate;
	private String updatedate;
	
	public int getNoticeNo() {
		return noticeNo;
	}
	public void setNoticeNo(int noticeNo) {
		this.noticeNo = noticeNo;
	}
	public String getNoticeMemo() {
		return noticeMemo;
	}
	public void setNoticeMemo(String noticeMemo) {
		this.noticeMemo = noticeMemo;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	public String getUpdatedate() {
		return updatedate;
	}
	public void setUpdatedate(String updatedate) {
		this.updatedate = updatedate;
	}
}
