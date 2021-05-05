package kr.happyjob.study.common.comnUtils;

import java.io.File;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.happyjob.study.system.model.FileModel;

/**
 * 
 * @author edit by.som
 *
 */
public class NewFileUtil {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
		
	// MultipartHttpServletRequest
	private HttpServletRequest HttpServletRequest;
	
	// root file path
	private String rootFilePath;
	
	// virtual file path
	private String virtualRootPath;
	
	// item file path
	private String itemFilePath;	
	
	
	// 이미지 파일 허용 확장자
	@Value("${image.allow.ext}")
	private String allowExt;
	
	
	
	
	public NewFileUtil(HttpServletRequest request, String rootFilePath, String virtualRootPath,
			String itemFilePath) {
		super();
		this.HttpServletRequest = request;
		this.rootFilePath = rootFilePath;
		this.virtualRootPath = virtualRootPath;
		this.itemFilePath = itemFilePath;
	}

	/** 
	 * 파일 업로드 
	 * @return 저장된 파일 메타 정보
	 */
	public List<FileModel> uploadFiles() throws Exception {
		
		logger.info("   - uploadFiles() started ");
		
		// Return value
		List<FileModel> listFileUtilModel = new ArrayList<FileModel>();
		
		// 디렉토리 생성
		makeDir();
        
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)HttpServletRequest;
		
        Iterator<String> files = multipartHttpServletRequest.getFileNames();
        
        while(files.hasNext()){
        	
            String uploadFile = files.next();

            MultipartFile multipartFile = multipartHttpServletRequest.getFile(uploadFile);
            String fileDvsCod = multipartFile.getName();
            logger.info("   - fileDvsCod : " + fileDvsCod);

            if (!multipartFile.isEmpty()) {
            	
            	FileModel fileModel = new FileModel();
            
            	String ofileName = multipartFile.getOriginalFilename(); // a.jpg
                String fileExtension = ofileName.substring(ofileName.lastIndexOf(".")+1); //jpg
                
                String newFileName = renameOfFile(ofileName); // uuid 붙인 파일 이름 생성
               
                String dirFileName = File.separator + itemFilePath + newFileName; // /product/a.jpg
                String localFilePath = rootFilePath+dirFileName;
                String serverFilePath = virtualRootPath+dirFileName; // web module에 등록된 가상 디렉토리
                int fileSize = (int)multipartFile.getSize(); // 532

               //파일 실제 업로드 로직
                File orgFile = new File(localFilePath); // 실제 시스템 디렉토리에 저장
                logger.info("   - localFilePath : " + localFilePath);
                logger.info("   - serverFilePath : " + serverFilePath);
                multipartFile.transferTo(orgFile);
               
                //디비 등록 용 로직
                logger.info("   - originalFileName : " + ofileName);
                logger.info("   - newFileName : " + newFileName);
                logger.info("   - fileExtension : " + fileExtension);
                fileModel.setFile_ofname(ofileName);
                fileModel.setFile_new_name(newFileName);
                fileModel.setFile_server_path(serverFilePath);
                fileModel.setFile_local_path(localFilePath);
                fileModel.setFile_exts(fileExtension);
                fileModel.setFile_size(fileSize);
                
                
                listFileUtilModel.add(fileModel);
                
            }
        }
        logger.info("   - uploadFiles() finished ");
        return listFileUtilModel;
	}	
	
	/**
	 * 파일 삭제
	 * @param listFileUtilModel
	 * @throws Exception
	 */
	public void deleteFiles(List<FileModel> listFileUtilModel) throws Exception {
		
		if (listFileUtilModel != null) {
			for(FileModel fileUtilModel : listFileUtilModel) {
				
				// 원본 파일 삭제
				String local_path = fileUtilModel.getFile_local_path();
				if (local_path != null && !"".equals(local_path)) {
					File file = new File(local_path);
					if (file.exists()) file.delete();
				}
			}
		}
	}	
	
	

	/**
	 * 파일명 랜덤 생성
	 * @param File file, String OriginalName
	 * @throws Exception
	 */
    private	String renameOfFile(String originalName) throws Exception{
        // uuid 생성(Universal Unique IDentifier, 범용 고유 식별자)
        UUID uuid = UUID.randomUUID();
        // 랜덤생성+파일이름 저장
        String newFileName = uuid.toString()+"_"+originalName;
        return newFileName;
    }    
	/**
	 * 디렉토리 생성
	 */
	private void makeDir() {
		
        // 디렉토리 파일 객체 생성
		String uploadFilePath = rootFilePath + itemFilePath;
        File file = new File(uploadFilePath);

        // 경로 생성
        if(!file.isDirectory()){
        	file.mkdirs();
        }
	}    
    

}
