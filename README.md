Maternity-Tracker
=================

 Namespace   | DSIO
 ----------- | ----
 Numberspace | 19641

Installation Instructions
-------------------------
#### Pre-Installation
Move/copy the [TITLES](/kids/TITLES) folder with containing text files to somewhere where you VistA database has read access. If you don’t know, you can find the information in the KERNEL SYSTEM PARAMERTS file under record IEN 1 as the PRIMARY HFS DIRECTORY field. During installation you will be prompted with “Enter directory name or path” with it defaulted to your PRIMARY HFS DIRECTORY this is asking where your extracted XML title documents are. 

During installation you will also be asked for the hospital location you wish to use for the Dashboard – if a selection is not made during this step then the Dashboard will not be able to create any TIU notes. This selection can be changed after installation through FileMan via the Enter/Edit option selecting the file DSIO TITLE CONFIGURATION.

#### Installation
Normal KIDS install through Kernel Installation & Distribution System.

During installation you will see…

          Running Post-Install Routine: POST^DSIO0P.
          
          ******************************************************************************
          Set the path where the TIU TITLE import files are located.
          
          Enter directory name or path: Pre-Installation Step Extraction Location


*Change this value to the location of the text files you extracted in the pre-installation step.*


          ******************************************************************************
          Choose your Maternity Tracker hospital location. All TIU notes created via the
		  dashboard will use this hospital location.
          
          Select HOSPITAL LOCATION: Select the Dashboard Hospital Location


*This is required for configuring the dashboard to use maternity related TIU notes, if not completed the dashboard will be unable to save a note and will have to be configured manually. Otherwise, the location can be changed after installation. In either case, the edits can be accomplished through FileMan via the DSIO TITLE CONFIGURATION file. To run post installation again you can “D ^DSIO99” at programmer prompt (without quotes).*

#### Post Installation
*DDCSFramework.bpl* is a Delphi package used for created new DDCS Forms. If you are not a developer and don’t plan on creating new DDCS Forms then you don’t need this file.

User Setup
----------
- Assign the Menu Context DSIO DDCS CONTEXT to users needing access to the DDCS Form Templates (DDCS Forms).
- Assign the Menu Context DSIO GUI CONTEXT to users needing access to the MCC Dashboard.
- Assign the Menu Context DSIO MAIN to users needing access to the VistA side configuration options.

*From the “Systems Manager Menu” option...*


          Core Applications ...
          Device Management ...
          VA FileMan ...
          Menu Management ...
          Programmer Options ...
          Operations Management ...
          Spool Management ...
          Information Security Officer Menu ...
          Taskman Management ...
          User Management ...
          Application Utilities ...
          Capacity Planning ...
          HL7 Main Menu ...
          Manage Mailman ...
          
          Select Systems Manager Menu Option: USER Management
          
          Add a New User to the System
          Grant Access by Profile
          Edit an Existing User
          Deactivate a User
          Reactivate a User
          List users
          User Inquiry
          Switch Identities
          File Access Security ...
          Clear Electronic signature code
          Electronic Signature Block Edit
          List Inactive Person Class Users
          Manage User File ...
          OAA Trainee Registration Menu ...
          Person Class Edit
          Reprint Access agreement letter
          
          Select User Management Option: EDIT an Existing User
          
          Select NEW PERSON NAME: Enter Name Here


![](/Documentation/readme_images/Register_Secondary_Option.png?raw=true)

##### Assign the Security Key DSIO CONFIG to users needing access to the GUI side configuration form.

*From the “Key Management” option...*


          Allocation of Security Keys
          De-allocation of Security Keys
          Enter/Edit of Security Keys
          All the Keys a User Needs
          Allocate/De-Allocate Exclusive Key(s)
          Change user's allocated keys to delegated keys
          Delegate keys
          Keys For a Given Menu Tree
          List users holding a certain key
          Remove delegated keys
          Show the keys of a particular user
          
          Select Key Management Option: ALLOCATION of Security Keys
          
          Allocate key: DSIO DDCS CONFIG
          
          Another key: 
          
          Holder of key: Enter Name Here
          
          Another holder: 
          
          You've selected the following keys: 
          
          DSIO DDCS CONFIG
          
          You've selected the following holders: 
          
          Entered Name Would Appear Here
          
          You are allocating keys.  Do you wish to proceed? YES//
          
          DSIO DDCS CONFIG being assigned to:
          Entered Name Would Appear Here


#### Triggers:
Set the following parameters to “YES” if the site wishes to flag patients for tracking during dashboard use. This would mean that the program will check for patients that should be flagged when a patient search action is performed within the dashboard – this compensates for not being able to flag patients at real-time. The alternative is to set the options, name the same as these parameters, as scheduled tasks.

 Parameters             | Options
 ---------------------- | ------------------
 DSIO EVAL CONSULTS NOW | DSIO EVAL CONSULTS
 DSIO EVAL LABS NOW	    | DSIO EVAL LABS
 DSIO EVAL PROBLEMS NOW | DSIO EVAL PROBLEMS

 
Create OE/RR ENTRY
------------------
This file is accessed by CPRS to use COM. There are only two fields required to use DSIO DDCS and that’s the NAME and OBJECT GUID fields. The GUID must look EXACTLY as seen below (with braces {}) but the name can be determined by the site.

*For file OE/RR COM OBJECTS create the following entry...*


INPUT TO WHAT FILE: OE/RR COM OBJECTS// 

          NAME: DSIO DDCS FORM BUILDER
          OBJECT GUID: {F4401FE9-4F5C-4633-B409-E7CEC0CE863F}
          INACTIVE: 
          PARAM1: 
          DESCRIPTION:
            No existing text
            Edit? NO//


			
Link TIU Titles in CPRS
-----------------------
The title must have be edited through the EDIT SHARED TEMPLATE option in CPRS with the title and COM entry.

In CPRS select a patient and navigate to the “Notes” tab and select the “Edit Templates” option under the “Options” menu. Select Document Titles and add a new template. This template must be a “Template Type” of “COM Object” with the “Associated Title” linked to the TIU Note Title you wish to have access this program with the “COM Object” field linked to the DSIO DDCS COM entry you created in the OE/RR COM Objects file.

![Image](/Documentation/readme_images/CPRS_Title_Link.png)

For more information check out the [VA Software Document Library](
http://www.va.gov/vdl/application.asp?appid=61).


Schedule the Task to PUSH Discreet Data
---------------------------------------
You may schedule the option DSIO DDCS CHECK STATUS to meet your needs. This option will look for captured data in the DSIO DDCS DATA file and in there are new records that have not been PUSHed it will check the DSIO DDCS CONTROL file if the TRIGGER event is acceptable and if so it will PUSH the data based on the linked DSIO DDCS REPORT ITEMS.

In the “Taskman Management” option…

          Schedule/Unschedule Options
          One-time Option Queue
          Taskman Management Utilities ...
          List Tasks
          Dequeue Tasks
          Requeue Tasks
          Delete Tasks
          Print Options that are Scheduled to run
          Cleanup Task List
          Print Options Recommended for Queueing
          
          Select Taskman Management Option: SCHEDULRE/Unschedule Options
          
          Select OPTION to schedule or reschedule: DSIO DDCS CHECK STATUS       Run DDCS Control Triggers for PUSH
            Are you adding 'DSIO DDCS CHECK STATUS' as a new OPTION SCHEDULING (the 143RD)? No// Y  (Yes)


![Image](/Documentation/readme_images/Option_Schedule.png)

*Set the fields appropriate to your site.*

Register the COM Object
-----------------------
In Windows, open the command prompt as an administrator and navigate to the COM Object that is located on the workstation that is accessing the DDCS Form Templates/oCNTs. Once your terminal is pointing to the same directory in which your COM resides run the command “regsvr32 DDCSFormBuilder.dll” without quotes.

![Image](/Documentation/readme_images/COM_regsvr32.png)


Setting the Location Parameter
------------------------------
This parameter is required as it and the configuration file needs to be able to build the absolute path that will allow COM to access and open the form dll. In this case if I am accessing the TIU Note Title that is under DDCS control (NURSE POSTPARTUM – MATERNAL) then the oCNT_NursePostpartumMaternal.dll must then be located where the parameter indicates so: C:\Users\USERNAME\Desktop\DDCS\_output\oCNT_NursePostpartumMaternal.dll

*Set the LOCATION parameter to the location of the dlls.*

          Select PARAMETER DEFINITION NAME: DSIO DDCS LOCATION     DSIO DDCS LOCATION
          
          ------ Setting DSIO DDCS LOCATION for System: ... ------
          LOCATION: C:\Users\USERNAME\Desktop\DDCS\_output\


DDCS FORMS (Delphi XE10)
========================
To install the DDCSFramework from source load the project DDCSFramework.dproj and then in the project manager you can right click the package name "DDCSFramework.bpl" and select install.

To load from DDCSFramework.bpl you can select the "Component" option "Install Packages" then select ADD and navigate to the .bpl and open.

You should now have the cagegory "DDCSForm" in your tool palette with TDDCSForm as an entry.

Quick Start - Your First DDCS (as a CPRS Note Extension) DLL
------------------------------------------------------------
1. In Delphi (XE10) create a New Project - Delphi Projects - Dynamic-link Library.

2. Right click the project name (Project1.dll) from the project manager and select "Add New" - "VCL Form". I changed the name of the form unit to frmMain. The source should now look like this...

	```pascal

	library Project1;

	{ Important note about DLL memory management: ShareMem must be the
	  first unit in your library's USES clause AND your project's (select
	  Project-View Source) USES clause if your DLL exports any procedures or
	  functions that pass strings as parameters or function results. This
	  applies to all strings passed to and from your DLL--even those that
	  are nested in records and classes. ShareMem is the interface unit to
	  the BORLNDMM.DLL shared memory manager, which must be deployed along
	  with your DLL. To avoid using BORLNDMM.DLL, pass string information
	  using PChar or ShortString parameters. }

	uses
	  System.SysUtils,
	  System.Classes,
	  frmMain in 'frmMain.pas' {Form1};

	{$R *.res}

	begin
	end.

	```
	
3. In your VCL Form unit go to your tool pallet and look for TDDCSForm (it's in the DDCSForm cagegory) and add it to your form. Make sure you add at least one page (right click the body of the component and select "New Page") before you add anything else. All components must be placed on a page in order to be picked up by DDCS.

4. Now lets go back to the source and make it look like the following...

	```pascal

	library Project1;

	{$R *.dres}

	uses
	  Winapi.Windows,
	  Vcl.Forms,
	  uExtndComBroker,
	  frmMain in 'frmMain.pas' {Form1};

	{$R *.res}

	function Launch(const CPRSBroker: PCPRSComBroker; out Return: WideString): WordBool; stdcall;
	var
	  oldHandle: HWND;
	begin
	  Result := False;

	  oldHandle := Application.Handle;
	  Application.Handle := GetActiveWindow;

	  RPCBrokerV := CPRSBroker^;
	  Form1 := TForm1.Create(nil);
	  try
		RPCBrokerV.DisabledWindow := DisableTaskWindows(0);
		Form1.ShowModal;
		if Form1.DDCSForm1.Validated then
		begin
		  Result := True;
		  Return := Form1.DDCSForm1.TmpStrList.Text;
		end;
	  finally
		Form1.Free;
		RPCBrokerV := nil;
		Application.Handle := oldHandle;
	  end;
	end;

	exports
	  Launch;

	begin
	end.

	```

5. The rest is up to you. Check out [Documentation](/Documentation) for an advanced guide to developing DDCS forms for CPRS TIU notes. *Will be updated at a later date.*