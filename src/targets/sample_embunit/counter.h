#ifndef	EMBUNIT_COUNTER_H
#define	EMBUNIT_COUNTER_H

typedef struct embCounter	Counter;
typedef struct embCounter*	CounterRef;

struct embCounter {
	int value;
};

CounterRef Counter_alloc(void);
void Counter_dealloc(CounterRef);
CounterRef Counter_init(CounterRef);
CounterRef Counter_counter(void);
int Counter_value(CounterRef);
void Counter_setValue(CounterRef,int);
int Counter_inc(CounterRef);
int Counter_dec(CounterRef);
void Counter_clr(CounterRef);

#endif/*EMBUNIT_COUNTER_H*/
