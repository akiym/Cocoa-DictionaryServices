#ifdef __cplusplus
extern "C" {
#endif

#define PERL_NO_GET_CONTEXT /* we want efficiency */
#include <EXTERN.h>
#include <perl.h>
#include <XSUB.h>

#ifdef __cplusplus
} /* extern "C" */
#endif

#define NEED_newSVpvn_flags
#include "ppport.h"

#import <Foundation/Foundation.h>
#import <CoreServices/CoreServices.h>

NSArray *DCSGetActiveDictionaries();
NSArray *DCSCopyAvailableDictionaries();
NSString *DCSDictionaryGetName(DCSDictionaryRef dictID);
NSString *DCSDictionaryGetShortName(DCSDictionaryRef dictID);

MODULE = Cocoa::DictionaryServices    PACKAGE = Cocoa::DictionaryServices

PROTOTYPES: DISABLE

void
lookup(char* string, ...)
PPCODE:
{
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];

    DCSDictionaryRef dictionary = NULL;

    if (items > 1) {
        char* ptr = (char*)SvPV_nolen(ST(1));
        NSString* activeDict = [NSString stringWithUTF8String:ptr];
        NSArray* dictionaries = DCSCopyAvailableDictionaries();
        for (NSObject* dict in dictionaries) {
            NSString* name = DCSDictionaryGetShortName((DCSDictionaryRef)dict);
            if ([name isEqualToString:activeDict]) {
                dictionary = (DCSDictionaryRef)dict;
            }
        }
    }

    NSString* word = [NSString stringWithUTF8String:string];
    NSString* result = (NSString*)DCSCopyTextDefinition(dictionary, (CFStringRef)word, DCSGetTermRangeInString(NULL, (CFStringRef)word, 0));

    if (result != NULL) {
        SV* sv_result = newSV(0);
        sv_setpv(sv_result, [result UTF8String]);

        PUSHs(sv_2mortal(sv_result));
    }

    [pool drain];
}

void
available_dictionaries()
PPCODE:
{
    NSArray* dicts = DCSCopyAvailableDictionaries();
    for (NSObject* dict in dicts) {
        NSString* name = DCSDictionaryGetShortName((DCSDictionaryRef)dict);

        SV* sv_name = newSV(0);
        sv_setpv(sv_name, [name UTF8String]);

        XPUSHs(sv_2mortal(sv_name));
    }
}
