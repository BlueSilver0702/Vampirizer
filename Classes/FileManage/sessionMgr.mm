
//
//  sessionMgr.m
//  ColorSplash
//
//  Created by Developer on 1/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#define SESSION_FILE_NAME	@"Session/"

#import "sessionMgr.h"
#import "QuartzCore/QuartzCore.h"

@implementation Session

@synthesize mResultImg, mThumbnailImg;

-(id) init
{
	
	mResultImg = nil;

	return self;
}

-(void)write:(NSString*)path index:(int)index
{
	BOOL isDir = NO;
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	if (!([fileManager fileExistsAtPath:path isDirectory:&isDir] && isDir))
	{
		[fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
	}
	
	NSData* writeDataResultImage = UIImagePNGRepresentation(mResultImg);
	NSData* writeDataThumbnailImage = UIImagePNGRepresentation(mThumbnailImg);
	// Create a thumbnail version of the image for the event object.
	if (index < 0)
		index = 999;

	[writeDataResultImage writeToFile:[Session GetMyFileName:path index:index prefix:@"Vampirizer_Image"] atomically:NO];	
	[writeDataThumbnailImage writeToFile:[Session GetMyFileName:path index:index prefix:@"Vampirizer_Thumbnail"] atomically:NO];	
	
		
}

-(UIImage *)readImage:(NSString*)path index:(int) index
{
	if (index < 0)
		index = 999;
	UIImage *pResultImg = nil;
	//check files exist
	if (![Session exist:path index:index])
		return pResultImg;

//	[self free];
	
	
	pResultImg = [[UIImage alloc] initWithContentsOfFile:[Session GetMyFileName:path index:index prefix:@"Vampirizer_Image"]];
		
	
	return pResultImg;
}

-(UIImage *)readThumnail:(NSString*)path index:(int) index
{
	if (index < 0)
		index = 999;
	UIImage *pResultImg = nil;
	//check files exist
	if (![Session exist:path index:index])
		return pResultImg;
	
	//	[self free];
	
	
	pResultImg = [[UIImage alloc] initWithContentsOfFile:[Session GetMyFileName:path index:index prefix:@"Vampirizer_Thumbnail"]];
	
	
	return pResultImg;
	
}

+ (BOOL) exist:(NSString *)path index:(int)index
{
	NSFileManager *fileManager = [NSFileManager defaultManager];
	if (index < 0)
		index = 999;

	if (![fileManager fileExistsAtPath:[Session GetMyFileName:path index:index prefix:@"Vampirizer_Image"]])
		return FALSE;
	
	return TRUE;
}

+ (BOOL) kill:(NSString *)path index:(int)index
{
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	[fileManager removeItemAtPath:[Session GetMyFileName:path index:index prefix:@"Vampirizer_Image"] error:nil];
	[fileManager removeItemAtPath:[Session GetMyFileName:path index:index prefix:@"Vampirizer_Thumbnail"] error:nil];
	
	return TRUE;
}

-(void)dealloc
{
//	[self free];
	[super dealloc];
}

-(void) free
{
	if (mResultImg)
		[mResultImg release];
	mResultImg = nil;
	if (mThumbnailImg)
		[mThumbnailImg release];
	mThumbnailImg = nil;
	
}

//- (UIImage *)roundedImage:(UIImage*)originalImage
//{
////    CGRect bounds = CGRectMake(0.0, 0.0, originalImage.size.width, originalImage.size.height);
////    UIImageView *temp_imageView = [[UIImageView alloc] initWithImage:originalImage];
////    CALayer *layer = temp_imageView.layer;
////    temp_imageView.frame = bounds;
////    [layer setMasksToBounds:YES];
////    [layer setCornerRadius:7.0];
////    [layer setBorderWidth:1.0];
////    [layer setBorderColor:[[UIColor darkGrayColor] CGColor]];
////    UIGraphicsBeginImageContext(bounds.size);
////    [layer renderInContext:UIGraphicsGetCurrentContext()];
////    UIImage *anImage = UIGraphicsGetImageFromCurrentImageContext();
////    UIGraphicsEndImageContext(); 
////    [temp_imageView release];
//	
//    return anImage;
//}
//
//
//- (void) loadWhole:(NSString*)path
//{
//	NSData *data;
//	
//	mOrgImg = [[UIImage alloc] initWithContentsOfFile:[Session GetMyFileName:path index:mMyNo prefix:@"input"]];
//	mResultImg = [[UIImage alloc] initWithContentsOfFile:[Session GetMyFileName:path index:mMyNo prefix:@"result"]];
//	
//	data = [[NSData alloc] initWithContentsOfFile:[Session GetMyFileName:path index:mMyNo prefix:@"stroke"]];
//	void* next = (void*)data.bytes;
//	while(((unsigned int)next - (unsigned int)data.bytes) < data.length)
//	{
//		maskStroke* one = [[maskStroke alloc] init];
//		next = [one Load:next];
//		[m_Data addObject:one];
//		[one release];
//	}
//	[data release];
//}
-(void)saveResultImage:(NSString*)path
{

	NSString *szFile;
	szFile = [path stringByAppendingPathComponent:@"Vampirizer_index.dat"];

	
//	FILE *fp;
//	fp = fopen([szFile cStringUsingEncoding:1], "wt");
//	fclose(fp);

	
	FILE *fp;
	fp = fopen([szFile cStringUsingEncoding:1], "rt");
	

	
	//Read index
	int nTotalIndexCount = 0;
	int* indexArray;
	int i;
	if(fp != NULL)
	{
		fseek(fp, 0, SEEK_END);
		long nFileSize = ftell(fp);
		nTotalIndexCount = nFileSize / (sizeof(int));
		rewind(fp);

	}

	indexArray = (int *)malloc(sizeof(int) * (nTotalIndexCount + 1));

	for (i = 0; i < nTotalIndexCount; i++)
	{
		int nTempIndex;
		fread(&nTempIndex, sizeof(int), 1, fp);
		indexArray[i] = nTempIndex;
	}
	
	fclose(fp);
	
	//Find Empty index
	int nEmptyIndex = 0;
	while (1) 
	{
		if ([Session exist:path index:nEmptyIndex] == FALSE)
		{
			break;
		}
		nEmptyIndex ++;
	}
	
	indexArray[nTotalIndexCount] = nEmptyIndex;
	nTotalIndexCount ++;
	[self write:path index:nEmptyIndex];
	
	fp = fopen([szFile cStringUsingEncoding:1], "wt");
	for (i = 0; i < nTotalIndexCount; i++)
	{
		int nTempIndex;
		nTempIndex = indexArray[i];
		fwrite(&nTempIndex, sizeof(int), 1, fp);
	}
	fclose(fp);

	free(indexArray);
	
}

-(UIImage* )loadResultImage:(NSString*)path index:(int) index
{
	
	NSString *szFile;
	szFile = [path stringByAppendingPathComponent:@"Vampirizer_index.dat"];

	FILE *fp = fopen([szFile cStringUsingEncoding:1], "rt");
	
	//Read index
	int nTotalIndexCount = 0;
	int* indexArray;
	int i;
	if(fp != NULL)
	{
		fseek(fp, 0, SEEK_END);
		long nFileSize = ftell(fp);
		nTotalIndexCount = nFileSize / (sizeof(int));
		rewind(fp);

	}
	else
	{
		return FALSE;
	}

	
	indexArray = (int *)malloc(sizeof(int) * (nTotalIndexCount + 1));
	
	for (i = 0; i < nTotalIndexCount; i++)
	{
		int nTempIndex;
		fread(&nTempIndex, sizeof(int), 1, fp);
		indexArray[i] = nTempIndex;
	}
	
	fclose(fp);
	
	//Finf Empty index
	int nRealIndex = indexArray[index];
	UIImage *pResultImg = nil;
	pResultImg = [self readImage:path index:nRealIndex];

	free(indexArray);
	return pResultImg;
}

-(UIImage *)loadThumbnailImage:(NSString*)path index:(int) index
{
	NSString *szFile;
	szFile = [path stringByAppendingPathComponent:@"Vampirizer_index.dat"];
	
	FILE *fp = fopen([szFile cStringUsingEncoding:1], "rt");
	
	//Read index
	int nTotalIndexCount = 0;
	int* indexArray;
	int i;
	if(fp != NULL)
	{
		fseek(fp, 0, SEEK_END);
		long nFileSize = ftell(fp);
		nTotalIndexCount = nFileSize / (sizeof(int));
		rewind(fp);
		
	}
	else
	{
		return FALSE;
	}
	
	
	indexArray = (int *)malloc(sizeof(int) * (nTotalIndexCount + 1));
	
	for (i = 0; i < nTotalIndexCount; i++)
	{
		int nTempIndex;
		fread(&nTempIndex, sizeof(int), 1, fp);
		indexArray[i] = nTempIndex;
	}
	
	fclose(fp);
	
	//Finf Empty index
	int nRealIndex = indexArray[index];
	UIImage *pResultImg = nil;
	pResultImg = [self readThumnail:path index:nRealIndex];
	
	free(indexArray);
	return pResultImg;
}

-(bool)deleteResultImage:(NSString*)path index:(int) index
{
	
	NSString *szFile;
	szFile = [path stringByAppendingPathComponent:@"Vampirizer_index.dat"];

	FILE *fp = fopen([szFile cStringUsingEncoding:1], "rt");
	
	//Read index
	int nTotalIndexCount = 0;
	int* indexArray;
	int i;
	if(fp != NULL)
	{
		fseek(fp, 0, SEEK_END);
		long nFileSize = ftell(fp);
		nTotalIndexCount = nFileSize / (sizeof(int));
		rewind(fp);

	}

	indexArray = (int *)malloc(sizeof(int) * (nTotalIndexCount + 1));
	
	for (i = 0; i < nTotalIndexCount; i++)
	{
		int nTempIndex;
		fread(&nTempIndex, sizeof(int), 1, fp);
		indexArray[i] = nTempIndex;
	}
	
	fclose(fp);	
	
	int nRealIndex = indexArray[index];
	[Session kill:path index:nRealIndex];

	for (i = index; i < nTotalIndexCount - 1; i++)
	{
		indexArray[i] = indexArray[i+1];
	}
	
	nTotalIndexCount --;
	fp = fopen([szFile cStringUsingEncoding:1], "wt");
	for (i = 0; i < nTotalIndexCount; i++)
	{
		int nTempIndex;
		nTempIndex = indexArray[i];
		fwrite(&nTempIndex, sizeof(int), 1, fp);
	}
	fclose(fp);
	
	
	free(indexArray);
	
	return TRUE;

}

-(int)getResultNum:(NSString*)path
{
	NSString *szFile;
	szFile = [path stringByAppendingPathComponent:@"Vampirizer_index.dat"];
	
	FILE *fp = fopen([szFile cStringUsingEncoding:1], "rt");
	
	//Read index
	int nTotalIndexCount = 0;
	if(fp != NULL)
	{
		fseek(fp, 0, SEEK_END);
		long nFileSize = ftell(fp);
		nTotalIndexCount = nFileSize / (sizeof(int));
	}
	fclose(fp);
	return nTotalIndexCount;
	
}

+ (NSString*) GetMyFileName:(NSString*) path index:(int)index prefix:(NSString*) prefix
{
	NSString* filePath = [NSString stringWithFormat:@"%@/%@%03d.dat", path, prefix, index];
	return filePath;
}

@end

