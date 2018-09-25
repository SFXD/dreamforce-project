/** Created by Nonix on 6/7/18.
 **/

public with sharing class ProfilePictureController {

    @AuraEnabled
    public static string getUserProfilePhotoUrl(Id userId) {
        Id theUserId = userId != null ? userId : UserInfo.getUserId();
        return ConnectApi.UserProfiles.getPhoto(null, String.valueOf(theUserId)).largePhotoUrl;
    }

    @AuraEnabled
    public static string setUserProfilePhoto(Id userId, String fileName, String base64Data, String contentType) {
        Id currentUserId = userId != null ? userId : UserInfo.getUserId();
        ConnectApi.BinaryInput pictureBinaryInput = new ConnectApi.BinaryInput(EncodingUtil.base64Decode(base64Data), contentType, fileName);
        ConnectApi.Photo userPhoto = ConnectApi.UserProfiles.setPhoto(null, currentUserId, pictureBinaryInput);

        return userPhoto.largePhotoUrl;
    }

}