//  rm main.trace;gcc -g main.c -o main `sdl2-config --cflags --libs` -lGL && apitrace trace --api gl ./main
#include "SDL.h"
#include "SDL_opengl.h"
#include "sm_shaders.h"
#include "sm_mesh.h"
#include <stdlib.h>
#include "matrix.c"

//#define WINDOWED
int main()
{
	SDL_Init(SDL_INIT_VIDEO);
	SDL_VideoInit(NULL);
	SDL_GL_SetAttribute(SDL_GL_CONTEXT_MAJOR_VERSION, 3);
	SDL_GL_SetAttribute(SDL_GL_CONTEXT_MINOR_VERSION, 2);
	SDL_GL_SetAttribute(SDL_GL_MULTISAMPLEBUFFERS, 1); 
	SDL_GL_SetAttribute(SDL_GL_MULTISAMPLESAMPLES, 8); 
#ifdef WINDOWED
	SDL_Window *win = SDL_CreateWindow("hello world", 0, 0,640, 480, SDL_WINDOW_OPENGL);
#define ASPECT 640.0/480
#else
	SDL_Window *win = SDL_CreateWindow("hello world", 0, 0,2560, 1440, SDL_WINDOW_OPENGL|SDL_WINDOW_FULLSCREEN);
#define ASPECT 2560.0/1440
#endif
	SDL_ShowWindow(win);

	SDL_GLContext context_dontneedtosavethis = SDL_GL_CreateContext(win);
	SDL_GL_SetSwapInterval(0);
#ifdef WINDOWED
	sm_screensize(640,480);
//	glViewport(0,0,640,480);
#else
	sm_screensize(2560,1440);
//	glViewport(0,0,1366,768);
#endif
	glEnable(GL_DEPTH_TEST);
	glEnable(GL_BLEND);
	glBlendFunc (GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);



	glClearColor(0.3,0.5,1,0);
	glClear(GL_COLOR_BUFFER_BIT);

	if(sm_load("gennormals"))return;
	if(sm_load("genpositions"))return;

	if(sm_load("example"))return;

	smm_open("radiomodel.tmd");
	GLuint examplemodelvao = smm_upload();
	int examplemodelnumtris =smm_numtris();


	if(sm_load("examplepp"))return;


	if(sm_load("drawtext"))return;
	unsigned char printtext[100] = {0};

	GLuint textvao, textvbo;//manually setup the text vao
	glGenVertexArrays(1,&textvao);
	glBindVertexArray(textvao);
	glGenBuffers(1,&textvbo);
	glBindBuffer(GL_ARRAY_BUFFER, textvbo);
	glBufferData(GL_ARRAY_BUFFER, /*sizeof(vertexdata)*/strlen(printtext), printtext, GL_STREAM_DRAW);
	glEnableVertexAttribArray(0);
	glVertexAttribPointer(0, 1, GL_UNSIGNED_BYTE, GL_FALSE, 0, 0);//associates first attribute with vertexdata, also sets source to vbo


	float modelviewproj[16];
	mat_identity(modelviewproj);
	mat_proj2(modelviewproj, 1.7453, ASPECT, 300, 0.1);



	long tstart = SDL_GetTicks();
	int i;
	float rot =0;
	float transx=0,transy=-5,transz=5;
	float rotmat[16];
	float wrot = 0;
	float wroty = 0;
	float speed = 0.001;
	mat_identity(rotmat);
	//SDL_SetRelativeMouseMode(SDL_TRUE);//this is not supported on all platforms, warping the mouse is more portable

	sm_use("gennormals");
	glDisable(GL_DEPTH_TEST);
	glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT);
	glBindVertexArray(examplemodelvao);
	glDrawElements(GL_TRIANGLES, examplemodelnumtris*3,  GL_UNSIGNED_SHORT, NULL);
	sm_use("genpositions");
	glDisable(GL_DEPTH_TEST);
	glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT);
	glDrawElements(GL_TRIANGLES, examplemodelnumtris*3,  GL_UNSIGNED_SHORT, NULL);
	
	for(i=0;i>=0;i++)
	{
		sm_use("example");
		glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT);
		glBindVertexArray(examplemodelvao);
		glDrawElements(GL_TRIANGLES, examplemodelnumtris*3,  GL_UNSIGNED_SHORT, NULL);


		sm_use("examplepp");
		glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT);
		glDrawArrays(GL_POINTS, 0, 1);//we're using attributeless rendering, so we don't need a vao


		sm_use("drawtext");
		glDisable(GL_DEPTH_TEST);
		glBindVertexArray(textvao);
		glEnable(GL_DEPTH_TEST);

		if(i%5==0)//calculate framerate every 5 frames
		{
			static long timesincelast;
			memset(printtext, 0, 100);
			long timethisframe = timesincelast-SDL_GetTicks();
			if(timethisframe != 0)
				SDL_itoa(1000*5/timethisframe, printtext, 10);
			strcat(printtext, "FPS");
			timesincelast = SDL_GetTicks();
			glBufferData(GL_ARRAY_BUFFER, strlen(printtext), printtext, GL_STREAM_DRAW);//upload the text as an ordinary string
		}
		glDisable(GL_DEPTH_TEST);
		glDrawArrays(GL_POINTS, 0,strlen(printtext));//draw the text to the screen
		glEnable(GL_DEPTH_TEST);

		SDL_GL_SwapWindow(win);
		SDL_Event evt;
		while(SDL_PollEvent(&evt))
		{
			if(evt.type == SDL_QUIT)
				i= -i;
		}

		const char *keys = SDL_GetKeyboardState(NULL);
		speed = 0.1;
		if(keys[SDL_SCANCODE_LSHIFT])
			speed = 2.8;
		if(keys[SDL_SCANCODE_W])
		{
			transz -=speed*cos(wrot);
			transx +=speed*sin(wrot);

		}
		if(keys[SDL_SCANCODE_A])
		{
			transz +=speed*cos(wrot-1.570796);
			transx -=speed*sin(wrot-1.570796);
		}
		if(keys[SDL_SCANCODE_S])
		{
			transz +=speed*cos(wrot);
			transx -=speed*sin(wrot);
		}
		if(keys[SDL_SCANCODE_D])
		{
			transz -=speed*cos(wrot-1.570796);
			transx +=speed*sin(wrot-1.570796);
		}
		if(keys[SDL_SCANCODE_SPACE])
			transy -=speed;
		if(keys[SDL_SCANCODE_LCTRL])
			transy +=speed;
		if(keys[SDL_SCANCODE_ESCAPE])
			break;
		int mousex, mousey;
		//SDL_GetRelativeMouseState(&mousex, &mousey);
		SDL_GetMouseState(&mousex, &mousey);
		SDL_WarpMouseInWindow(win, 400,400);
		mousex = mousex-400;
		mousey = mousey-400;
		wrot -= mousex/1000.0;
		wroty-= mousey/1000.0;
		wroty = wroty > 1.57?1.57:wroty<-1.57?-1.57:wroty;

		float temp[16];
		mat_identity(temp);
		mat_mul(temp, modelviewproj);
		mat_rot(temp, 1,0,0,wroty);
		mat_rot(temp, 0,1,0,wrot);
		mat_trans(temp, transx, transy, transz);
		mat_mul(temp, rotmat);
		mat_scale(temp, 10, 10, 10);
		sm_use("example");
		glUniformMatrix4fv(sm_uniloc("modelviewproj"), 1, GL_TRUE, temp);//upload the model-view-projection matrix
	}
	i = -i;



	printf("last sdl error:%s\n", SDL_GetError());
	printf("vendor:%s\n", glGetString(GL_RENDERER));
}
