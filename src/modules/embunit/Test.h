/*
 * COPYRIGHT AND PERMISSION NOTICE
 * 
 * Copyright (c) 2003 Embedded Unit Project
 * 
 * All rights reserved.
 * 
 * Permission is hereby granted, free of charge, to any person obtaining 
 * a copy of this software and associated documentation files (the 
 * "Software"), to deal in the Software without restriction, including 
 * without limitation the rights to use, copy, modify, merge, publish, 
 * distribute, and/or sell copies of the Software, and to permit persons 
 * to whom the Software is furnished to do so, provided that the above 
 * copyright notice(s) and this permission notice appear in all copies 
 * of the Software and that both the above copyright notice(s) and this 
 * permission notice appear in supporting documentation.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT 
 * OF THIRD PARTY RIGHTS. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR 
 * HOLDERS INCLUDED IN THIS NOTICE BE LIABLE FOR ANY CLAIM, OR ANY 
 * SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAGES WHATSOEVER 
 * RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF 
 * CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN 
 * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 * 
 * Except as contained in this notice, the name of a copyright holder 
 * shall not be used in advertising or otherwise to promote the sale, 
 * use or other dealings in this Software without prior written 
 * authorization of the copyright holder.
 *
 * $Id: Test.h,v 1.4 2004/02/10 16:19:29 arms22 Exp $
 */
#ifndef	EMBUNIT_TEST_H
#define	EMBUNIT_TEST_H

typedef struct embTestResult		TestResult;
typedef struct embTestResult*	TestResultRef;/*downward compatible*/

typedef struct embTestImplement	TestImplement;
typedef struct embTestImplement*	TestImplementRef;/*downward compatible*/

typedef char*(*TestNameFunction)(void*);
typedef void(*TestRunFunction)(void*,TestResult*);
typedef int(*TestCountTestCasesFunction)(void*);

struct embTestImplement {
	TestNameFunction name;
	TestRunFunction run;
	TestCountTestCasesFunction countTestCases;
};

typedef struct embTest	Test;
typedef struct embTest*	TestRef;/*downward compatible*/

struct embTest {
	TestImplement* isa;
};

#define Test_name(s)			((Test*)s)->isa->name(s)
#define Test_run(s,r)			((Test*)s)->isa->run(s,r)
#define Test_countTestCases(s)	((Test*)s)->isa->countTestCases(s)

#endif/*EMBUNIT_TEST_H*/
