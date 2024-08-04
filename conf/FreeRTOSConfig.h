#ifndef FREERTOS_CONFIG_H
#define FREERTOS_CONFIG_H

#define configUSE_PREEMPTION        1
#define configUSE_IDLE_HOOK         1
#define configUSE_TICK_HOOK         1
#define configCPU_CLOCK_HZ          ( ( unsigned long ) 100*1000*1000 ) /* Clock setup from main.c in the demo application. */
#define configTICK_RATE_HZ          ( ( TickType_t ) 1000 )
#define configMAX_PRIORITIES        ( 16 )
#define configMINIMAL_STACK_SIZE    ( ( unsigned short ) 1024 )
#define configTOTAL_HEAP_SIZE       ( ( size_t ) ( 16*1024 ) )
#define configMAX_TASK_NAME_LEN     ( 8 )
#define configUSE_TRACE_FACILITY    0
#define configUSE_16_BIT_TICKS      0
#define configIDLE_SHOULD_YIELD     1
#define configUSE_MUTEXES           1

#define configUSE_RECURSIVE_MUTEXES      1
#define configUSE_COUNTING_SEMAPHORES    1
#define configSUPPORT_DYNAMIC_ALLOCATION 1
#define configUSE_MALLOC_FAILED_HOOK     1
#define configCHECK_FOR_STACK_OVERFLOW   1

// necessary for FreeRTOS-POSIX pthread
#define configSUPPORT_STATIC_ALLOCATION  1
#define configUSE_POSIX_ERRNO            1
#define configUSE_APPLICATION_TASK_TAG   1
#define INCLUDE_xQueueGetMutexHolder     1

/* Co-routine definitions. */
#define configUSE_CO_ROUTINES           1
#define configMAX_CO_ROUTINE_PRIORITIES ( 2 )

/* Set the following definitions to 1 to include the API function, or zero
to exclude the API function. */
#define INCLUDE_vTaskPrioritySet        1
#define INCLUDE_uxTaskPriorityGet       1
#define INCLUDE_vTaskDelete             1
#define INCLUDE_vTaskCleanUpResources   0
#define INCLUDE_vTaskSuspend            1
#define INCLUDE_vTaskDelayUntil         1
#define INCLUDE_vTaskDelay              1
#define INCLUDE_eTaskGetState           1
#define INCLUDE_uxTaskGetStackHighWaterMark 1

/* RISC-V mtime address */
#define configMTIME_BASE_ADDRESS        ( 0x2000BFF8UL )
#define configMTIMECMP_BASE_ADDRESS     ( 0x20004000UL )

#endif