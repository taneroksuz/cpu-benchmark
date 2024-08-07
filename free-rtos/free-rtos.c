#define USER_DEFINED_IDLE_HOOK

#include "common.h"

#if configUSE_IDLE_HOOK
void vApplicationIdleHook( void )
{
	vCoRoutineSchedule();
}
#endif

int main(void)
{
	printf("*********************************\n");
	printf("****** Hello From FreeRTOS ******\n");
	printf("*********************************\n");

	return 1;
}