#ifndef __TYPES_H
#define __TYPES_H 1

#ifndef NULL
#define NULL ((void *)0)
#endif

/* TODO: make more portable. Check different archictectures and define based on that. #error on no standard found
 *       Instead take advantage of compiler defined macros
 */
#if defined(__clang__) || defined(__GNUC__) || defined(__GNUG__)
typedef __INT32_TYPE__ int32_t;
typedef __INT16_TYPE__ int16_t;
typedef __INT8_TYPE__  int8_t;

typedef __UINT32_TYPE__ uint32_t;
typedef __UINT16_TYPE__ uint16_t;
typedef __UINT8_TYPE__  uint8_t;

typedef __WCHAR_TYPE__ wchar_t;
typedef __WINT_TYPE__  wint_t;

typedef __PTRDIFF_TYPE__ ptrdiff_t;
typedef __INTPTR_TYPE__  intptr_t;
typedef __UINTPTR_TYPE__ uintptr_t;
#elif defined(_MSC_VER)
#error TODO: MSCV
#else
#error Compiler not detected. You must define your own standard types. Delete or comment this line after you do so.
typedef signed /* */ int32_t;
typedef signed /* */ int16_t;
typedef signed /* */ int8_t;

typedef unsigned /* */ uint32_t;
typedef unsigned /* */ uint16_t;
typedef unsigned /* */ uint8_t;

typedef /* */ wchar_t;
typedef /* */ wint_t;

typedef signed /* */ ptrdiff_t;
typedef signed   /* */  intptr_t;
typedef unsigned /* */  uintptr_t;
#endif

typedef int8_t result_t;

typedef struct str8_t str8_t;
struct str8_t {
  char   *buf;
  int32_t len;
};

typedef struct str16_t str16_t;
struct str16_t {
  int16_t *buf;
  int32_t  len;
};

typedef struct str32_t str32_t;
struct str32_t {
  int32_t *buf;
  int32_t  len;
};

#if __STDC_VERSION__ < 199901L
/* c89 requires constant initializers */
extern str8_t _nkl_str8_make(const char *s, const int32_t size);
#define STR8(s) _nkl_str8_make(s, (int32_t)(sizeof(s) - 1))
#else
#define STR8(s) ((str8_t) {s, (int32_t)(sizeof(s) - 1)})
#endif

