unit frmAbout;

{
   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.

     Developer: Theodore Fontana
       Company: Document Storage Systems Inc.
   VA Contract: TAC-13-06464
}

interface

uses
  Windows, SysUtils, Forms, StdCtrls, ExtCtrls, JclFileUtils, Vcl.Imaging.pngimage,
  Vcl.Controls, System.Classes, Vcl.Graphics, Vcl.Themes;

type
  TDDCSAbout = class(TForm)
    pnlInfo: TPanel;
    lbAppName: TStaticText;
    btnOk: TButton;
    lbWebDSS: TStaticText;
    imgDSS: TImage;
    imgVA: TImage;
    lbCompany: TLabel;
    lbApache: TLabel;
    lbCopyright: TLabel;
    lbLicense: TLabel;
    lbWebVA: TStaticText;
    procedure FormShow(Sender: TObject);
    procedure HyperLinkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

var
  DDCSAbout: TDDCSAbout;

implementation

uses
  dateutils, shellAPI;

{$R *.DFM}

procedure TDDCSAbout.FormCreate(Sender: TObject);
begin
  SetWindowLong(Handle, GWL_EXSTYLE, getWindowLong(Handle, GWL_EXSTYLE) or WS_EX_TOOLWINDOW);
end;

procedure TDDCSAbout.FormShow(Sender: TObject);
var
  vi: TJclFileVersionInfo;
begin
  vi := TJclFileVersionInfo.Create(HInstance);
  try
    lbAppName.Caption := vi.ProductName + ' ' + vi.ProductVersion;
    lbCopyRight.Caption := 'Copyright ' + Chr(169) + ' 1995 - ' + IntToStr(YearOf(Now));
    lbCompany.Caption := vi.CompanyName;

    lbLicense.Caption := 'Licensed under the Apache License, Version 2.0 (the "License");' + #13#10 +
                         'you may not use this file except in compliance with the License.' + #13#10 +
                         'You may obtain a copy of the License at' + #13#10 +
                         '' + #13#10 +
                         '   http://www.apache.org/licenses/LICENSE-2.0' + #13#10 +
                         '' + #13#10 +
                         'Unless required by applicable law or agreed to in writing, software' + #13#10 +
                         'distributed under the License is distributed on an "AS IS" BASIS,' + #13#10 +
                         'WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.' + #13#10 +
                         'See the License for the specific language governing permissions and' + #13#10 +
                         'limitations under the License.'

  finally
    vi.Free;
  end;
end;

procedure TDDCSAbout.HyperLinkClick(Sender: TObject);
begin
  ShellExecute(Application.Handle, PChar('open'), PChar(TStaticText(Sender).Caption), nil, nil, SW_SHOWNORMAL);
end;

end.