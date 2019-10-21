#include <vcl.h>
#pragma hdrstop
#include <tchar.h>


USEFORM("updateForm.cpp", UpdateFormObj);
USEFORM("mainForm.cpp", MainFormObj);

int WINAPI _tWinMain(HINSTANCE, HINSTANCE, LPTSTR, int) {
	try {
		Application->Initialize();
		Application->MainFormOnTaskBar = true;
		Application->CreateForm(__classid(TMainFormObj), &MainFormObj);
		Application->CreateForm(__classid(TUpdateFormObj), &UpdateFormObj);
		Application->Run();
	}
	catch (Exception &exception) {
		Application->ShowException(&exception);
	}
	catch (...) {
		try {
			throw Exception("");
		}
		catch (Exception &exception) {
			Application->ShowException(&exception);
		}
	}

	return 0;
}
