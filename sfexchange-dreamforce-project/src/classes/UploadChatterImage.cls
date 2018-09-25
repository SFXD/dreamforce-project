public without sharing class UploadChatterImage {
    
@AuraEnabled
  public static Document document {
    get {
      if (document == null)
        document = new Document();
      return document;
    }
    set;
  }

  public PageReference upload() {
    Blob b;
    document.AuthorId = UserInfo.getUserId();
    document.FolderId = UserInfo.getUserId(); // put it in running user's folder

    try{
      document.type = 'jpg'; 
      document.IsPublic = true;
      insert document;
     // ImageId = '06990000001HnuB';
      b = document.Body;
      //ConnectApi.ChatterUsers newPhoto = new ConnectApi.ChatterUsers();
         
   
   
    } catch (DMLException e) {
      ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading file'));
      return null;
    } finally {
      document.body = null; // clears the viewstate
      document = new Document();
    }

    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'File uploaded successfully : '+b));
    String communityId = null;
    String userId= UserInfo.getUserId();
    //ID fileId = ImageId;

    // Set photo
    ConnectApi.Photo photo = ConnectApi.UserProfiles.setPhoto(communityId, userId,  new ConnectApi.BinaryInput(b,'image/jpg','userImage.jpg'));
    return null;
  }

}