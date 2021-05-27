package kr.happyjob.study.system.model;

public class FileModel {
	
	private int file_no;	
	private String file_local_path;
	private String file_relative_path;
	private String file_ofname;
	private int file_size;	
	
	public int getFile_no() {
		return file_no;
	}
	public void setFile_no(int file_no) {
		this.file_no = file_no;
	}
	public String getFile_local_path() {
		return file_local_path;
	}
	public void setFile_local_path(String file_local_path) {
		this.file_local_path = file_local_path;
	}
	public String getFile_relative_path() {
    return file_relative_path;
  }
  public void setFile_relative_path(String file_relative_path) {
    this.file_relative_path = file_relative_path;
  }
  public String getFile_ofname() {
		return file_ofname;
	}
	public void setFile_ofname(String file_ofname) {
		this.file_ofname = file_ofname;
	}
	public int getFile_size() {
		return file_size;
	}
	public void setFile_size(int file_size) {
		this.file_size = file_size;
	}
	
}
