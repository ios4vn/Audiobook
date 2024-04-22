/* Copyright (c) 2016 Google Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

//
//  GTLYouTubeActivityContentDetailsSocial.h
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   YouTube Data API (youtube/v3)
// Description:
//   Supports core YouTube features, such as uploading videos, creating and
//   managing playlists, searching for content, and much more.
// Documentation:
//   https://developers.google.com/youtube/v3
// Classes:
//   GTLYouTubeActivityContentDetailsSocial (0 custom class methods, 5 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

@class GTLYouTubeResourceId;

// ----------------------------------------------------------------------------
//
//   GTLYouTubeActivityContentDetailsSocial
//

// Details about a social network post.

@interface GTLYouTubeActivityContentDetailsSocial : GTLObject

// The author of the social network post.
@property (nonatomic, copy) NSString *author;

// An image of the post's author.
@property (nonatomic, copy) NSString *imageUrl;

// The URL of the social network post.
@property (nonatomic, copy) NSString *referenceUrl;

// The resourceId object encapsulates information that identifies the resource
// associated with a social network post.
@property (nonatomic, retain) GTLYouTubeResourceId *resourceId;

// The name of the social network.
@property (nonatomic, copy) NSString *type;

@end
