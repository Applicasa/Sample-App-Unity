#import "ApplicasaCore.h"
#import "LiCore/LiUtilities.h"
extern "C" {

    void ApplicasaGetCachedData(const char * url, ApplicasaGetFileData eventCallback) {
        NSURL* fileurl = [NSURL URLWithString:[CharPointerToNSString(url) stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        [fileurl getCachedDataWithBlock:ApplicasaGetFileDataToDataBlock(eventCallback)];
    }

    void ApplicasaGetCachedImage(const char * url, ApplicasaGetFileData eventCallback) {
        NSURL* imageurl = [NSURL URLWithString:[CharPointerToNSString(url) stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        [imageurl getCachedImageWithBlock:ApplicasaGetFileDataToImageBlock(eventCallback)];
    }
    

}