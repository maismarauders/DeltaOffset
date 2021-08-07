#include <stdio.h>

extern "C" void Shellcode_ENTRY();

int main(int argc, char *argv[])
{
	// Call into our shellcode
	Shellcode_ENTRY();
	return 0;
}
