/*
 *  types.h
 *  PhotoPicker
 *
 *  Created by KCU on 11/3/10.
 *  Copyright 2010 __MyCompanyName__. All rights reserved.
 *
 */

#ifndef _TYPES_INC_
#define _TYPES_INC_

struct point
{
	int x;
	int y;
};

enum enPointType
{
	PT_None,
	PT_LeftPupil,
	PT_RightPupil,
	PT_MouthCenter,
	PT_ChinCenter,
	PT_LeftMouthCorner,
	PT_RightMouthCorner,
	PT_LeftShoulder,
	PT_RightShoulder,
	PT_Belly, 		        
	PT_TipToe,
	PT_Chin,
};

#endif //_TYPES_INC_