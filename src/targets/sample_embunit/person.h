#ifndef	EMBUNIT_PERSON_H
#define	EMBUNIT_PERSON_H

typedef struct embPerson		Person;
typedef struct embPerson*	PersonRef;

struct embPerson {
	char *fullname;
	char *firstname;
	char *lastname;
};

PersonRef Person_alloc(void);
PersonRef Person_init(PersonRef);
PersonRef Person_initWithName(PersonRef,char*);
PersonRef Person_personWithName(char*);
void Person_dealloc(PersonRef);
char* Person_fullName(PersonRef);
char* Person_firstName(PersonRef);
char* Person_lastName(PersonRef);
void Person_setFullName(PersonRef,char*);
void Person_setFirstName(PersonRef,char*);
void Person_setLastName(PersonRef,char*);

#endif/*EMBUNIT_PERSON_H*/
