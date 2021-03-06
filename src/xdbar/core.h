#ifndef __CORE_H__
#define __CORE_H__

#include <stdarg.h>
#include <stdint.h>

#define MAX_BLKS       (1 << 6)
#define BLOCK_BUF_SIZE (1 << 10)

#define eprintf(...) fprintf(stderr, __VA_ARGS__);
#define die(...)                                                               \
  {                                                                            \
    eprintf("[ERROR] ");                                                       \
    eprintf(__VA_ARGS__);                                                      \
    exit(1);                                                                   \
  }

typedef enum { ReadyEvent, DrawEvent, NoActionEvent } BarEvent;
typedef enum { Stdin, Custom } BlockType;

typedef struct {
  uint32_t x, y, w, h;
} Geometry;

typedef struct {
  int topbar : 1;
  Geometry geometry;
  struct {
    uint32_t left, right, top, bottom;
  } padding, margin;
  char foreground[16], background[16];
} BarConfig;

typedef struct {
  int nfonts;
  char **fonts;
  BarConfig barConfig;
} Config;

void usage(void);

#endif
