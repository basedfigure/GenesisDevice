{*******************************************************************************
*                            Genesis Device Engine                             *
*                   Copyright © 2007-2015 Luuk van Venrooij                    *
*                        http://www.luukvanvenrooij.nl                         *
*                         luukvanvenrooij84@gmail.com                          *
********************************************************************************
*                                                                              *
*  This file is part of the Genesis Device Engine.                             *
*                                                                              *
*  The Genesis Device Engine is free software: you can redistribute            *
*  it and/or modify it under the terms of the GNU Lesser General Public        *
*  License as published by the Free Software Foundation, either version 3      *
*  of the License, or any later version.                                       *
*                                                                              *
*  The Genesis Device Engine is distributed in the hope that                   *
*  it will be useful, but WITHOUT ANY WARRANTY; without even the               *
*  implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.    *
*  See the GNU Lesser General Public License for more details.                 *
*                                                                              *
*  You should have received a copy of the GNU General Public License           *
*  along with Genesis Device.  If not, see <http://www.gnu.org/licenses/>.     *
*                                                                              *
*******************************************************************************}   
unit GDInterface;

{$MODE Delphi}

interface

uses
  Dialogs,
  Windows,
  dglOPengl,
  SysUtils,
  GDRenderer,
  GDInput,
  GDSound,
  GDMain,
  GDConstants,
  GDConsole,
  GDSettings,
  GDTiming,
  GDLog,
  GDTypes,
  GDCommands,
  GDGUI,
  GDCamera,
  GDOctree,
  GDFrustum,
  GDFont,
  GDMap,
  GDTerrain,
  GDSkyDome,
  GDWater,
  GDFoliage,
  GDFog,
  GDCellManager,
  GDTexture,
  GDMesh,
  GDMaterials,
  GDObjectList,
  GDLighting,
  GDStatistics,
  GDModes,
  GDCallBack; 
  
Var
  FEngineInitialized   : Boolean = false;
  FRendererInitialized : Boolean = false;
  FInputInitialized    : boolean = false;
  FSoundInitialized    : boolean = false;

 //some functions to check the engine 
function CheckEngineInitialized(): boolean;
function CheckRendererInitialized(): boolean;
function CheckInputInitialized(): boolean;
function CheckSoundInitialized(): boolean; 

//Engine Functions
function  gdEngineInit(aApplicationPath, aApplicationName : PChar) : Boolean; 
procedure gdEngineShutDown(); 
function  gdEngineBuildDate() : PChar; 
function  gdEngineBuildNumber() : PChar;  

//settings functions
procedure gdSettingsLoad( aIniFile : PChar );
procedure gdSettingsSave( aIniFile : PChar ); 
procedure gdSettingsHigh();
procedure gdSettingsMedium();
procedure gdSettingsLow();
procedure gdSettingsSafe();
function  gdSettingsGetCurrent() : TSettings; 
procedure gdSettingsSetCurrent(aSettings : TSettings); 
function  gdSettingsGetMaximum() : TMaximumSettings; 

//log functions
function  gdLogGetLine(aRow : Integer) : Pchar; 
procedure gdLogAddNewLine(aText : Pchar); 
procedure gdLogAddToLastLine(aText : Pchar); 
procedure gdLogSave(); 
procedure gdLogClear(); 

//timing functions
procedure gdTimerStart(); 
procedure gdTimerStop(); 
function  gdTimerGetInSeconds() : PChar; 
function  gdTimerGetInMilliSeconds() : PChar; 

//callback functions
procedure gdCallBackSetInterfaceRenderer( aFunction : TGDProcEngineCallback );
procedure gdCallBackSetBeforeRender( aFunction : TGDProcEngineCallback ); 
procedure gdCallBackSetAfterRender( aFunction : TGDProcEngineCallback ); 

//loop functions
procedure gdLoopMain(); 
procedure gdLoopRender();                                                   

//renderer functions
function  gdRenderSystemInit( aWnd  : HWND ) : boolean; 
function  gdRenderSystemShutDown() : boolean; 
function  gdRenderSystemRestart() : boolean; 
procedure gdRenderSystemResize(aTop, aLeft, aWidth, aHeight : integer); 
procedure gdRenderSystemSetState(aState : TGDRenderState);
function  gdRenderSystemGetFrameTime() : Integer; 
procedure gdRenderSystemScreenShot( aFileName : PChar ) ; 

//sound functions
function  gdSoundSystemCheckVersion() : Boolean; 
function  gdSoundSystemNumberOfDrivers() : Integer; 
function  gdSoundSystemGetDriverName( aDriverNumber : Integer ) : PChar; 
function  gdSoundSystemInit() : boolean; 
function  gdSoundSystemShutDown() : boolean; 

//input functions
function  gdInputSystemInit() : boolean; 
function  gdInputSystemShutDown() : boolean; 
function  gdInputSystemStringToKey( aName : PChar ) : Integer ; 
function  gdInputSystemKeyToString( aKey : Integer ) : Pchar ; 
function  gdInputSystemDetectCurrentKeyString() : Pchar ; 
function  gdInputSystemDetectCurrentKey() : Integer ; 
procedure gdInputSystemRegisterAction(aType : TGDInputTypes; aName, aKeyString : PChar ;
                                      aAction : TGDProcEngineCallback;  aConsoleDisabled : boolean ); 
procedure gdInputSystemHandleChar( aChar : PChar ); 
procedure gdInputSystemUseMouseLook( aUse : boolean ); 
procedure gdInputSystemEnable( aEnable : boolean ); 

//console functions
procedure gdConsoleInit( aInput : TGDConsoleInput ); 
procedure gdConsoleClear(); 
procedure gdConsoleToggle(); 

//commands functions
procedure gdCommandExecute( aString : PChar ); 

//gui functions
procedure gdGUIMouseCursorInit( aFileName : PChar; aSize : integer ); 
procedure gdGUIMouseCursorClear(); 
procedure gdGUIMouseCursorShow(aShow : boolean); 
function  gdGUIMouseCursorGetPosition() : TPoint; 
procedure gdGUILoadingScreenInit( aInput : TGDLoadingInput ); 
procedure gdGUILoadingScreenClear(); 
procedure gdGUILoadingScreenSetup( aProcessName : PChar; aMax : Integer ); 
procedure gdGUILoadingScreenUpdate(); 

//camera functions
procedure gdCameraInit(aX,aY,aZ : double); 
procedure gdCameraSetPosition(aX,aY,aZ : double); 
function  gdCameraGetPosition() : TGDVectorRecord; 
procedure gdCameraSetDirection(aX,aY,aZ : double); 
function  gdCameraGetDirection() : TGDVectorRecord; 
procedure gdCameraMove(aStep : double); 
procedure gdCameraStrafe(aStep : double); 
procedure gdCameraUpDown(aStep : double); 
procedure gdCameraMouseLook(aOldX, aOldY, aNewX, aNewY  : Integer; aSensitivity : Double; aInvertMouse : Boolean); 
procedure gdCameraMouseLookHorizontal(aOldX, aNewX  : Integer; aSensitivity : Double; aInvertMouse : Boolean); 
procedure gdCameraMouseStrafe(aOldX, aNewX  : Integer; aStep : Double); 
procedure gdCameraMouseUpDown(aOldY, aNewY  : Integer; aStep : Double); 
procedure gdCameraMouseMove(aOldY, aNewY : Integer; aStep : Double);

//octree functions
procedure gdOctreeRebuild(); 
procedure gdOctreeClear();

//map functions
function  gdMapLoad( aFileName : PChar ) : boolean; 
procedure gdMapClear(); 

//terrain functions
function  gdTerrainInit( aInput : TGDTerrainInput ) : boolean; 
procedure gdTerrainClear(); 
function  gdTerrainHeight(aX, aZ : Double) : Double; 
function  gdTerrainRotation(aX, aZ : Double) : TGDVectorRecord; 

//skydome functions
procedure gdSkyDomeInit(aFileName : PChar); 
procedure gdSkyDomeClear(); 

//distancefog functions
procedure gdDistanceFogInit( aR,aG,aB,aA : Double  ); 
procedure gdDistanceFogClear(); 

//water functions
function  gdWaterInit( aInput : TGDWaterInput ) : boolean; 
procedure gdWaterClear(); 
function  gdWaterHeight(): Double; 

//foliage function
procedure gdFoliageInit( aInput : TGDFoliageInput );
procedure gdFoliageAddGrassType( aInput : TGDGrassTypesInput );
procedure gdFoliageAddTreeType( aInput : TGDTreeTypesInput );
procedure gdFoliageClear();

//texture functions
function  gdTexturesLoad( aFileName : String ) : pointer; 
procedure gdTexturesBind( aPointer : pointer; aTextureUnit : TGDTextureUnit ); 
procedure gdTexturesClear(); 
procedure gdTexturesRemove( aPointer : pointer ); 

//font functions
function  gdFontsLoad( aFileName : String ) : pointer; 
procedure gdFontsSetColor(aPointer : pointer; aR,aG,aB,aA : double); 
procedure gdFontsRenderText(aPointer : pointer; aX,aY,aScale : Double; aText : Pchar); 
procedure gdFontsClear(); 
procedure gdFontsRemove( aPointer : pointer ); 

//main ambient light
procedure gdMainDirectionalLightSet( aInput : TGDDirectionalLightInput );
procedure gdMainDirectionalLightClear();

//sound functions
function  gdSoundFilesLoad( aFileName : PChar; aType : TGDSoundTypes ) : pointer; 
procedure gdSoundFilesRemove( aPointer : pointer ); 
procedure gdSoundFilesClear(); 
procedure gdSoundFilesPlay( aPointer : pointer ); 
procedure gdSoundFilesPause( aPointer : pointer ); 
procedure gdSoundFilesResume( aPointer  : pointer ); 

implementation

{******************************************************************************}
{* Check if the engine is initialized                                         *}
{******************************************************************************}

function CheckEngineInitialized(): boolean;
begin
  If not(FEngineInitialized) then MessageBox(0, 'Engine is not initialized!', 'Error', MB_OK or MB_ICONERROR);
  result := FEngineInitialized;
end;

{******************************************************************************}
{* Check if the renderer is initialized                                       *}
{******************************************************************************}

function CheckRendererInitialized(): boolean;
begin
  If not(FRendererInitialized) then MessageBox(0, 'Renderer is not initialized!', 'Error', MB_OK or MB_ICONERROR);
  result := FRendererInitialized;
end;

{******************************************************************************}
{* Check if the input is initialized                                       *}
{******************************************************************************}

function CheckInputInitialized(): boolean;
begin
  If not(FInputInitialized) then MessageBox(0, 'Input is not initialized!', 'Error', MB_OK or MB_ICONERROR);
  result := FInputInitialized;
end;

{******************************************************************************}
{* Check if the sound is initialized                                          *}
{******************************************************************************}

function CheckSoundInitialized(): boolean;
begin
  If not(FSoundInitialized) then MessageBox(0, 'Sound is not initialized!', 'Error', MB_OK or MB_ICONERROR);
  result := FSoundInitialized;
end;

{******************************************************************************}
{* Initialize the engine`s core                                               *}
{******************************************************************************}

function gdEngineInit(aApplicationPath, aApplicationName : PChar) : Boolean; 
begin
  If FEngineInitialized then
  begin
     ShowMessage('Engine is already initialized!');
     result := false;
     exit;
  end;

  Log := TGDLog.Create( String(aApplicationPath) + String(aApplicationName) + '.log' );
  InitOpenGL();
  Settings := TGDSettings.Create();
  Settings.ApplicationFilePath := aApplicationPath;
  Settings.ApplicationFileName := aApplicationName;
  DefaultFormatSettings.DecimalSeparator := '.';

  If Not(Settings.DetectOpengl()) then
  begin
     result := false;
     exit;
  end;

  If Not(Settings.CheckCapabilities()) then
  begin
     result := false;
     exit;
  end;

  If Not(Settings.CheckFileSystem()) then
  begin
     result := false;
     exit;
  end;

  //create all classes
  Main         := TGDMain.Create();
  Renderer     := TGDRenderer.Create();
  Input        := TGDInput.Create();
  InputManager := TGDInputManager.Create();
  Sound        := TGDSound.Create();
  SoundList    := TGDObjectList.Create();
  Console      := TGDConsole.Create();
  Camera       := TGDCamera.Create();
  Frustum      := TGDFrustum.Create();
  SystemFont   := TGDFont.Create();
  Timer        := TGDPerformanceTiming.Create();
  Timing       := TGDTiming.Create();
  Map          := TGDMap.Create();
  Terrain      := TGDTerrain.Create();
  SkyDome      := TGDSkyDome.Create();
  Water        := TGDWater.Create();
  Octree       := TGDOcTree.Create();
  Foliage      := TGDFoliage.Create();
  Statistics   := TGDStatistics.Create();
  Modes        := TGDModes.Create();
  CallBack     := TGDCallBack.Create();
  FogManager     := TGDFogManager.Create();
  CellManager    := TGDCellManager.Create();
  TextureList    := TGDObjectList.Create();
  MaterialList   := TGDMaterialList.Create();
  GUIManager     := TGDGUIManager.Create();
  MeshList       := TGDMeshList.Create();
  FontList       := TGDObjectList.Create;
  Commands       := TGDCommands.Create();
  DirectionalLight := TGDDirectionalLight.Create();
  result := true;
  FEngineInitialized := true;
end;

{******************************************************************************}
{* Shutdown the engine`s core                                                 *}
{******************************************************************************}

procedure gdEngineShutDown(); 
begin
  If Not(FEngineInitialized) then exit;
  FreeAndNil(InputManager);
  FreeAndNil(Input);
  FreeAndNil(Console);
  FreeAndNil(Camera);
  FreeAndNil(Renderer);
  FreeAndNil(SoundList);
  FreeAndNil(Sound);
  FreeAndNil(GUIManager);
  FreeAndNil(Frustum);
  FreeAndNil(SystemFont);
  FreeAndNil(FontList);
  FreeAndNil(Map);
  FreeAndNil(Terrain);
  FreeAndNil(Timing);
  FreeAndNil(Foliage);
  FreeAndNil(SkyDome);
  FreeAndNil(Water);
  FreeAndNil(Commands);
  FreeAndNil(FogManager);
  FreeAndNil(CellManager);
  FreeAndNil(MeshList);
  FreeAndNil(Octree);
  FreeAndNil(TextureList);
  FreeAndNil(Timer);
  FreeAndNil(Main);
  FreeAndNil(Settings);
  FreeAndNil(MaterialList);
  FreeAndNil(Log);
  FreeAndNil(Statistics);
  FreeAndNil(CallBack);
  FreeAndNil(DirectionalLight);
  FreeAndNil(Modes);
end;

{******************************************************************************}
{* Get the builddate of the engine                                            *}
{******************************************************************************}

function gdEngineBuildDate() : PChar; 
begin
   result := ENGINE_BUILDDATE;
end;

{******************************************************************************}
{* Get the buildnumber of the engine                                          *}
{******************************************************************************}

function gdEngineBuildNumber() : PChar; 
begin
  result := ENGINE_BUILD;
end;

{******************************************************************************}
{* Initialize the renderer                                                    *}
{******************************************************************************}

function gdRenderSystemInit( aWnd  : HWND ) : boolean; 
begin
  If Not(CheckEngineInitialized()) then
  begin
    result := false;
    exit;
  end;

  If FRendererInitialized then
  begin
     MessageBox(0, 'Renderer is already initialized!', 'Error', MB_OK or MB_ICONERROR);
     result := false;
     exit;
  end;
  If Renderer.InitRenderer( aWnd ) then
  begin
     result := true;
     FRendererInitialized := true;
  end
  else
  begin
     result := false;
     FRendererInitialized := false;
  end;
end;

{******************************************************************************}
{* Shutdown the renderer                                                      *}
{******************************************************************************}

function gdRenderSystemShutDown() : boolean; 
begin
  If Not(FEngineInitialized) then
  begin
    result := false;
    exit;
  end;

  If Not(FRendererInitialized) then
  begin
    result := false;
    exit;
  end;

  result := Renderer.ShutDownRenderer();
  If result then
  begin
    FRendererInitialized := false;
  end;
end;

{******************************************************************************}
{* Restart the renderer                                                       *}
{******************************************************************************}

function gdRenderSystemRestart() : boolean; 
begin
  If Renderer.ShutDownRenderer() then
     result := Renderer.InitRenderer( Renderer.WindowHandle )
  else
    result := false;
end;

{******************************************************************************}
{* Resize the viewport of the engine                                          *}
{******************************************************************************}

procedure gdRenderSystemResize(aTop, aLeft, aWidth, aHeight : integer); 
begin
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  Settings.Top := aTop;
  Settings.Left := aLeft;
  Settings.Width := aWidth;
  Settings.Height := aHeight;
  InputManager.CalculateMousePosStart();
  Renderer.ResizeViewPort();
end;

{******************************************************************************}
{* Set the current renderstate                                                *}
{******************************************************************************}

procedure gdRenderSystemSetState(aState : TGDRenderState);
begin
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  Renderer.RenderState(aState);
end;

{******************************************************************************}
{* Main render loop of the engine                                             *}
{******************************************************************************}

function gdRenderSystemGetFrameTime() : Integer; 
begin
  result := 0;
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  result := Timing.FrameTime;
end;

{******************************************************************************}
{* Save a screenshot to a file                                                *}
{******************************************************************************}

procedure gdRenderSystemScreenShot( aFileName : PChar ) ; 
begin
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  Console.CommandString := 'ScreenShot ' + String(aFileName);
  Console.ExecuteCommand := true;
end;

{******************************************************************************}
{* Check if the soundengine version is ok for the engine                      *}
{******************************************************************************}

function gdSoundSystemCheckVersion() : Boolean; 
begin
  result := false;
  If Not(FEngineInitialized) then exit;
  result := Sound.CheckVersion();
end;

{******************************************************************************}
{* Get the number of sounddrivers the soundengine supports                    *}
{******************************************************************************}

function gdSoundSystemNumberOfDrivers() : Integer; 
begin
  If Not(FEngineInitialized) then exit;
  result := Sound.GetNumberOfDrivers();
end;

{******************************************************************************}
{* Get the name string of a driver                                            *}
{******************************************************************************}

function gdSoundSystemGetDriverName( aDriverNumber : Integer ) : PChar; 
begin
  If Not(FEngineInitialized) then exit;
  result :=  PChar(Sound.GetDriverName( aDriverNumber ));
end;

{******************************************************************************}
{* Initialize the soundsystem                                                 *}
{******************************************************************************}

function gdSoundSystemInit() : boolean; 
begin
  If Not(CheckEngineInitialized()) then
  begin
    result := false;
    exit;
  end;

  If FSoundInitialized then
  begin
     MessageBox(0, 'soundengine is already initialized!', 'Error', MB_OK or MB_ICONERROR);
     result := false;
     exit;
  end;

  If Sound.InitSoundEngine() then
  begin
     result := true;
     FSoundInitialized := true;
  end
  else
  begin
     result := false;
     FSoundInitialized := false;
  end;
end;

{******************************************************************************}
{* Shutdown the soundengine                                                    *}
{******************************************************************************}

function gdSoundSystemShutDown() : boolean; 
begin
  If Not(FEngineInitialized) then
  begin
    result := false;
    exit;
  end;

  If Not(FSoundInitialized) then
  begin
    result := false;
    exit;
  end;

  result := Sound.ShutDownSoundEngine();
  If result then
  begin
    FSoundInitialized := false;
  end;
end;

{******************************************************************************}
{* Initialize input                                                           *}
{******************************************************************************}

function gdInputSystemInit() : boolean; 
begin
  If Not(CheckEngineInitialized()) then
  begin
    result := false;
    exit;
  end;

  If FInputInitialized then
  begin
     MessageBox(0, 'Input is already initialized!', 'Error', MB_OK or MB_ICONERROR);
     result := false;
     exit;
  end;
  If Input.InitDirectInput() then
  begin
     result := true;
     FInputInitialized := true;
  end
  else
  begin
     result := false;
     FInputInitialized := false;
  end;
end;

{******************************************************************************}
{* Shutdown input                                                             *}
{******************************************************************************}

function gdInputSystemShutDown() : boolean; 
begin
  If Not(FEngineInitialized) then
  begin
    result := false;
    exit;
  end;

  If Not(CheckInputInitialized()) then
  begin
    result := false;
    exit;
  end;

  result := Input.ShutDownInput();
  If result then FInputInitialized := false;
end;

{******************************************************************************}
{* Keystring to key                                                           *}
{******************************************************************************}

function gdInputSystemStringToKey( aName : PChar ) : Integer ; 
begin
  If Not(FEngineInitialized) then exit;
  If Not(FInputInitialized) then exit;
  result := Input.StringToKey( aName );
end;

{******************************************************************************}
{* Key to keytring                                                            *}
{******************************************************************************}

function gdInputSystemKeyToString( aKey : Integer ) : Pchar ; 
begin
  If Not(FEngineInitialized) then exit;
  If Not(FInputInitialized) then exit;
  result := PChar(Input.KeyToString( aKey ));
end;

{******************************************************************************}
{* Detect which Key is currently pressed and returns the keystring            *}
{******************************************************************************}

function gdInputSystemDetectCurrentKeyString() : Pchar ; 
begin
  If Not(FEngineInitialized) then exit;
  If Not(FInputInitialized) then exit;
  result := PChar(Input.DetectCurrentKeyString());
end;

{******************************************************************************}
{* Detect which Key is currently pressed and returns it                       *}
{******************************************************************************}

function gdInputSystemDetectCurrentKey() : Integer ; 
begin
  If Not(FEngineInitialized) then exit;
  If Not(FInputInitialized) then exit;
  result := Input.DetectCurrentKey();
end;

{******************************************************************************}
{* Register a keyaction                                                       *}
{******************************************************************************}

procedure gdInputSystemRegisterAction(aType : TGDInputTypes; aName, aKeyString : PChar ;
                                      aAction : TGDProcEngineCallback;  aConsoleDisabled : boolean ); 
begin
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  If Not(FInputInitialized) then exit;
  InputManager.RegisterInputAction(aType, String(aName), String(aKeyString), aAction, aConsoleDisabled );
end;

{******************************************************************************}
{* Pas down a char the engine (used for typing and such)                      *}
{******************************************************************************}

procedure gdInputSystemHandleChar( aChar : PChar ); 
begin
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  If Not(FInputInitialized) then exit;
  InputManager.ExecuteCharInput( Char(aChar) );
end;

{******************************************************************************}
{* Toggle use of mouselook                                                    *}
{******************************************************************************}

procedure gdInputSystemUseMouseLook( aUse : boolean ); 
begin
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  If Not(FInputInitialized) then exit;
  InputManager.MouseLook := aUse;
end;

{******************************************************************************}
{* Enable or disable input                                                    *}
{******************************************************************************}

procedure gdInputSystemEnable( aEnable : boolean ); 
begin
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  If Not(FInputInitialized) then exit;
  Input.EnableInput := aEnable;
end;

{******************************************************************************}
{* Initialize the console                                                     *}
{******************************************************************************}

procedure gdConsoleInit( aInput : TGDConsoleInput ); 
begin
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  If Not(FInputInitialized) then exit;
  Console.InitConsole( aInput  );
end;

{******************************************************************************}
{* Clear the console                                                          *}
{******************************************************************************}

procedure gdConsoleClear(); 
begin
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  If Not(FInputInitialized) then exit;
  Console.Clear();
end;

{******************************************************************************}
{* Toggle the console                                                         *}
{******************************************************************************}

procedure gdConsoleToggle(); 
begin
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  If Not(FInputInitialized) then exit;
  Console.Show := Not(Console.Show);
end;

{******************************************************************************}
{* Excute command                                                             *}
{******************************************************************************}

procedure gdCommandExecute(aString : PChar ); 
begin
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  Console.CommandString := String(aString);
  Console.ExecuteCommand := true;
  Commands.ExecuteCommand();
end;

{******************************************************************************}
{* Initialize the mouse cursor                                                *}
{******************************************************************************}

procedure gdGUIMouseCursorInit( aFileName : PChar; aSize : integer ); 
begin
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  If Not(FInputInitialized) then exit;
  GUIManager.MouseCursor.InitMouse( String(aFileName) , aSize );
end;

{******************************************************************************}
{* Clear the mouse cursor                                                     *}
{******************************************************************************}

procedure gdGUIMouseCursorClear(); 
begin
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  If Not(FInputInitialized) then exit;
  GUIManager.MouseCursor.Clear();
end;

{******************************************************************************}
{* Show or hide the mouse cursor                                              *}
{******************************************************************************}

procedure gdGUIMouseCursorShow(aShow : boolean); 
begin
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  If Not(FInputInitialized) then exit;
  InputManager.CalculateMousePosStart();
  GUIManager.MouseCursor.ShowMouse := aShow;
end;

{******************************************************************************}
{* retrieve mouse cursor position                                             *}
{******************************************************************************}

function gdGUIMouseCursorGetPosition() : TPoint; 
begin
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  If Not(FInputInitialized) then exit;
  result.X := GUIManager.MouseCursor.Position.X;
  result.Y := GUIManager.MouseCursor.Position.Y;
end;

{******************************************************************************}
{* Initialize the loadingscreen                                               *}
{******************************************************************************}

procedure gdGUILoadingScreenInit( aInput : TGDLoadingInput ); 
begin
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  If Not(FInputInitialized) then exit;
  GUIManager.LoadingScreen.InitLoadingScreen( aInput );
end;

{******************************************************************************}
{* Clear the loadingscreen                                                    *}
{******************************************************************************}

procedure gdGUILoadingScreenClear(); 
begin
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  If Not(FInputInitialized) then exit;
  GUIManager.LoadingScreen.Clear();
end;

{******************************************************************************}
{* Setup the loadingscreen                                                    *}
{******************************************************************************}

procedure gdGUILoadingScreenSetup( aProcessName : PChar; aMax : Integer ); 
begin
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  If Not(FInputInitialized) then exit;
  GUIManager.LoadingScreen.SetupForUse(String(aProcessName),aMax);
end;

{******************************************************************************}
{* Update the loadingscreen                                                   *}
{******************************************************************************}

procedure gdGUILoadingScreenUpdate(); 
begin
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  If Not(FInputInitialized) then exit;
  GUIManager.LoadingScreen.UpdateBar();
end;

{******************************************************************************}
{* Initialize the camera                                                      *}
{******************************************************************************}

procedure gdCameraInit(aX,aY,aZ : double); 
begin
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  Camera.InitCamera(aX,aY,aZ);
end;

{******************************************************************************}
{* Set the camera position                                                     *}
{******************************************************************************}

procedure gdCameraSetPosition(aX,aY,aZ : double); 
begin
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  Camera.Position.X := aX;
  Camera.Position.Y := aY;
  Camera.Position.Z := aZ;
end;

{******************************************************************************}
{* Get the camera position                                                     *}
{******************************************************************************}

function gdCameraGetPosition() : TGDVectorRecord; 
begin
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  result.x := Camera.Position.X;
  result.y := Camera.Position.Y;
  result.z := Camera.Position.Z;
end;

{******************************************************************************}
{* Set the camera direction                                                   *}
{******************************************************************************}

procedure gdCameraSetDirection(aX,aY,aZ : double); 
begin
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  Camera.Direction.X := aX;
  Camera.Direction.Y := aY;
  Camera.Direction.Z := aZ;
end;

{******************************************************************************}
{* Get the camera direction                                                   *}
{******************************************************************************}

function gdCameraGetDirection() : TGDVectorRecord; 
begin
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  result.x := Camera.Direction.X;
  result.y := Camera.Direction.Y;
  result.z := Camera.Direction.Z;
end;

{******************************************************************************}
{* Move camera forward or backwards                                           *}
{******************************************************************************}

procedure gdCameraMove(aStep : double); 
begin
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  Camera.Move(aStep);
end;

{******************************************************************************}
{* Strafe camera right or left                                                *}
{******************************************************************************}

procedure gdCameraStrafe(aStep : double); 
begin
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  Camera.Strafe(aStep);
end;

{******************************************************************************}
{* Move camera up or down                                                     *}
{******************************************************************************}

procedure gdCameraUpDown(aStep : double); 
begin
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  Camera.UpDown(aStep);
end;

{******************************************************************************}
{* Look arround with the mouse                                               *}
{******************************************************************************}

procedure gdCameraMouseLook(aOldX, aOldY, aNewX, aNewY  : Integer; aSensitivity : Double; aInvertMouse : Boolean); 
begin
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  Camera.MouseLook(aOldX, aOldY, aNewX, aNewY,aSensitivity,aInvertMouse);
end;

{******************************************************************************}
{* Look horizontaly with the mouse                                            *}
{******************************************************************************}

procedure gdCameraMouseLookHorizontal(aOldX, aNewX  : Integer; aSensitivity : Double; aInvertMouse : Boolean); 
begin
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  Camera.MouseLookHorizontal(aOldX, aNewX, aSensitivity, aInvertMouse);
end;

{******************************************************************************}
{* Strafe horizontaly with the mouse                                          *}
{******************************************************************************}

procedure gdCameraMouseStrafe(aOldX, aNewX  : Integer; aStep : Double); 
begin
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  Camera.MouseStrafe(aOldX, aNewX, aStep );
end;

{******************************************************************************}
{* Move up and down with the mouse                                            *}
{******************************************************************************}

procedure gdCameraMouseUpDown(aOldY, aNewY  : Integer; aStep : Double); 
begin
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  Camera.MouseUpDown(aOldY, aNewY, aStep);
end;

{******************************************************************************}
{* Move with the mouse                                                        *}
{******************************************************************************}

procedure gdCameraMouseMove(aOldY, aNewY : Integer; aStep : Double); 
begin
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  Camera.MouseMove( aOldY, aNewY, aStep );
end;

{******************************************************************************}
{* Rebuild the quadtree                                                       *}
{******************************************************************************}

procedure gdOctreeRebuild(); 
begin
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  Octree.InitOcTree();
end;

{******************************************************************************}
{* Rebuild the quadtree                                                       *}
{******************************************************************************}

procedure gdOctreeClear(); 
begin
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  Octree.InitOcTree();
end;

{******************************************************************************}
{* Load settings out an ini-file                                              *}
{******************************************************************************}

procedure gdSettingsLoad( aIniFile : PChar );
begin
  If Not(FEngineInitialized) then exit;
  Settings.LoadIniFile(aIniFile);
end;

{******************************************************************************}
{* Save settings to an ini-file                                               *}
{******************************************************************************}

procedure gdSettingsSave( aIniFile : PChar ); 
begin
  If Not(FEngineInitialized) then exit;
  Settings.SaveIniFile( aIniFile );
end;

{******************************************************************************}
{* Set settings to high                                                       *}
{******************************************************************************}

procedure gdSettingsHigh();
begin
  If Not(FEngineInitialized) then exit;
  Settings.HighSettings();
end;

{******************************************************************************}
{* Set settings to medium                                                     *}
{******************************************************************************}

procedure gdSettingsMedium();
begin
  If Not(FEngineInitialized) then exit;
  Settings.MediumSettings();
end;

{******************************************************************************}
{* Set settings to low                                                        *}
{******************************************************************************}

procedure gdSettingsLow();
begin
  If Not(FEngineInitialized) then exit;
  Settings.LowSettings();
end;

{******************************************************************************}
{* Set settings to safe                                                       *}
{******************************************************************************}

procedure gdSettingsSafe();
begin
  If Not(FEngineInitialized) then exit;
  Settings.SafeSettings();
end;

{******************************************************************************}
{* Retrieve the current settings                                              *}
{******************************************************************************}

function  gdSettingsGetCurrent() : TSettings; 
begin
  If Not(FEngineInitialized) then exit;
  result := Settings.GetSettings();
end;

{******************************************************************************}
{* Set the current settings                                                   *}
{******************************************************************************}

procedure gdSettingsSetCurrent(aSettings : TSettings); 
begin
  If Not(FEngineInitialized) then exit;
  Settings.SetSettings(aSettings);
end;

{******************************************************************************}
{* Get the maximum settings                                                   *}
{******************************************************************************}

function gdSettingsGetMaximum() : TMaximumSettings; 
begin
  If Not(FEngineInitialized) then exit;
  result := Settings.GetMaximumSettings();
end;

{******************************************************************************}
{* Retrieve a log-line                                                        *}
{******************************************************************************}

function gdLogGetLine(aRow : Integer) : Pchar; 
begin
  If Not(FEngineInitialized) then exit;
  If (aRow < 0) or (aRow > Log.Text.Count-1) then
    result := 'NO_LINE'
  else
    result := PCHar(Log.Text.Strings[aRow]);
end;

{******************************************************************************}
{* Add a text to the log                                                      *}
{******************************************************************************}

procedure gdLogAddNewLine(aText : Pchar); 
begin
  If Not(FEngineInitialized) then exit;
  If aText = '' then exit;
  Log.AddNewLine(String(aText));
end;

{******************************************************************************}
{* Add a text to the last line of the log                                     *}
{******************************************************************************}

procedure gdLogAddToLastLine(aText : Pchar); 
begin
  If Not(FEngineInitialized) then exit;
  If aText = '' then exit;
  Log.AddToLastLine(String(aText));
end;

{******************************************************************************}
{* Save the log                                                               *}
{******************************************************************************}

procedure gdLogSave(); 
begin
  If Not(FEngineInitialized) then exit;
  Log.SaveLog();
end;

{******************************************************************************}
{* Clear the log                                                              *}
{******************************************************************************}

procedure gdLogClear(); 
begin
  If Not(FEngineInitialized) then exit;
  Log.ClearLog();
end;

{******************************************************************************}
{* Start timer                                                                *}
{******************************************************************************}

procedure gdTimerStart(); 
begin
  If Not(FEngineInitialized) then exit;
  Timer.Start();
end;

{******************************************************************************}
{* Stop timer                                                                 *}
{******************************************************************************}

procedure gdTimerStop(); 
begin
  If Not(FEngineInitialized) then exit;
  Timer.Stop();
end;

{******************************************************************************}
{* Get time in seconds                                                        *}
{******************************************************************************}

function gdTimerGetInSeconds() : PChar; 
begin
  If Not(FEngineInitialized) then exit;
  result := PChar(Timer.TimeInSeconds());
end;

{******************************************************************************}
{* Get time in millids                                                        *}
{******************************************************************************}

function gdTimerGetInMilliSeconds() : PChar; 
begin
  If Not(FEngineInitialized) then exit;
  result := PChar(Timer.TimeInMilliSeconds());
end;

{******************************************************************************}
{* Sets the RenderInterface callback function                                 *}
{******************************************************************************}

procedure gdCallBackSetInterfaceRenderer( aFunction : TGDProcEngineCallback ); 
begin
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  RenderInterfaceCallBack := aFunction;
end;

{******************************************************************************}
{* Sets the beforerender callback function                                    *}
{******************************************************************************}

procedure gdCallBackSetBeforeRender( aFunction : TGDProcEngineCallback ); 
begin
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  AfterRenderCallBack := aFunction;
end;

{******************************************************************************}
{* Sets the afterrender callback function                                     *}
{******************************************************************************}

procedure gdCallBackSetAfterRender( aFunction : TGDProcEngineCallback ); 
begin
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  BeforeRenderCallBack := aFunction;
end;

{******************************************************************************}
{* Main loop of the engine                                                    *}
{******************************************************************************}

procedure gdLoopMain(); 
begin
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  If Not(FInputInitialized) then exit;
  If Not(FSoundInitialized) then exit;
  Main.Main();
end;

{******************************************************************************}
{* Main render loop of the engine                                             *}
{******************************************************************************}

procedure gdLoopRender(); 
begin
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  Main.RenderMain();
end;

{******************************************************************************}
{* Load map                                                                   *}
{******************************************************************************}

function gdMapLoad( aFileName : PChar ) : boolean; 
begin
  result := false;
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  Octree.Clear();
  CellManager.Cells.Clear();
  result := Map.InitMap( String(aFileName) );
  CellManager.GenerateAllCells();
  Octree.InitOcTree();
  Camera.InitCamera(Map.PlayerStart.X,Map.PlayerStart.Y,Map.PlayerStart.Z);
  Camera.Rotation.x := Map.PlayerViewAngle.X;
  Camera.Rotation.y := Map.PlayerViewAngle.y;
  Camera.Rotation.z := Map.PlayerViewAngle.z;
  Camera.MouseLook(0,0,1,1,0,False);
end;

{******************************************************************************}
{* Clear map                                                                  *}
{******************************************************************************}

procedure gdMapClear(); 
begin
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  Map.Clear();
  CellManager.Clear();
  Octree.Clear();
end;

{******************************************************************************}
{* Load terrain                                                               *}
{******************************************************************************}

function gdTerrainInit( aInput : TGDTerrainInput ) : boolean; 
begin
  Result := false;
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  Terrain.Clear();
  Result := Terrain.InitTerrain( aInput );
  CellManager.RemoveCells( SO_TERRAINCELL );
  CellManager.GenerateCellsFromTerrain();
  Octree.Clear();
  Octree.InitOcTree();
end;

{******************************************************************************}
{* Clear terrain                                                              *}
{******************************************************************************}

procedure gdTerrainClear(); 
begin
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  Terrain.Clear();
  CellManager.RemoveCells( SO_TERRAINCELL );
  Octree.Clear();
  Octree.InitOcTree();
end;

{******************************************************************************}
{* Return the height of the terrain at a point                                *}
{******************************************************************************}

function gdTerrainHeight(aX, aZ  : Double) : Double; 
var
  iHeight : Double;
begin
  result := 0;
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  Terrain.GetHeight( aX, aZ, iHeight );
  result := iHeight;
end;

{******************************************************************************}
{* Return the rotation of the terrain at a point                              *}
{******************************************************************************}

function  gdTerrainRotation(aX, aZ : Double) : TGDVectorRecord; 
var
  iRotation : TGDVector;
begin
  iRotation := TGDVector.Create();
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  Terrain.GetRotation( aX, aZ, iRotation );
  result.x := iRotation.x;
  result.y := iRotation.y;
  result.z := iRotation.z;
  FreeAndNil(iRotation);
end;

{******************************************************************************}
{* Init skydome                                                               *}
{******************************************************************************}

procedure gdSkyDomeInit(aFileName : PChar); 
begin
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  SkyDome.InitSkyDome( String(aFileName), (Settings.ViewDistance * R_VIEW_DISTANCE_STEP));
end;

{******************************************************************************}
{* Clear skydome                                                              *}
{******************************************************************************}

procedure gdSkyDomeClear(); 
begin
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  SkyDome.Clear();
end;

{******************************************************************************}
{* Init distancefog                                                           *}
{******************************************************************************}

procedure gdDistanceFogInit( aR,aG,aB,aA : Double  ); 
begin
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  FogManager.InitDistanceFog(aR,aG,aB,aA,Settings.ViewDistance );
  FogManager.UseDistanceFog();
end;

{******************************************************************************}
{* Clear distancefog                                                          *}
{******************************************************************************}

procedure gdDistanceFogClear(); 
begin
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  FogManager.ClearDistanceFog();
end;

{******************************************************************************}
{* Init water                                                                 *}
{******************************************************************************}

function  gdWaterInit( aInput : TGDWaterInput ) : boolean; 
begin
  result := false;
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  Water.Clear();
  result := Water.InitWater( aInput );
  FogManager.InitWaterFog( aInput.UnderWaterColorR,aInput.UnderWaterColorG,aInput.UnderWaterColorB,aInput.UnderWaterColorA, aInput.Visibility );
  CellManager.RemoveCells( SO_WATERCELL );
  CellManager.GenerateCellsFromWater();
  Octree.Clear();
  Octree.InitOcTree();
end;

{******************************************************************************}
{* Clear water                                                                *}
{******************************************************************************}

procedure gdWaterClear(); 
begin
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  CellManager.RemoveCells( SO_WATERCELL );
  Water.Clear();
  Octree.Clear();
  Octree.InitOcTree();
end;

{******************************************************************************}
{* return the waterheight                                                     *}
{******************************************************************************}

function gdWaterHeight(): Double; 
begin
  result := 0;
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  result := Water.WaterHeight;
end;

{******************************************************************************}
{* Init foliage                                                               *}
{******************************************************************************}

procedure gdFoliageInit( aInput : TGDFoliageInput );
begin
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  Foliage.InitFoliage( aInput );
  CellManager.RemoveCells( SO_GRASSCELL );
  CellManager.GenerateCellsFromFoliage();
  Octree.Clear();
  Octree.InitOcTree();
end;

{******************************************************************************}
{* Add a grasstype                                                            *}
{******************************************************************************}

procedure gdFoliageAddGrassType( aInput : TGDGrassTypesInput );
var
  iGrassType : TGDGrassType;
begin
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  iGrassType := TGDGrassType.Create();
  iGrassType.InitGrassType( aInput );
  Foliage.GrassTypes.Add(iGrassType);
end;

{******************************************************************************}
{* Add a treetype                                                             *}
{******************************************************************************}

procedure gdFoliageAddTreeType( aInput : TGDTreeTypesInput );
var
  iTreeType : TGDTreeType;
begin
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  iTreeType := TGDTreeType.Create();
  //iTreeType.InitTreeType( aInput );
  Foliage.TreeTypes.Add(iTreeType);
end;

{******************************************************************************}
{* Clear foliage                                                              *}
{******************************************************************************}

procedure gdFoliageClear();
begin
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  CellManager.RemoveCells( SO_GRASSCELL );
  Foliage.Clear();
  Octree.Clear();
  Octree.InitOcTree();
end;

{******************************************************************************}
{* Load a texture from a file and return the retrievel index                  *}
{******************************************************************************}

function gdTexturesLoad( aFileName : String ) : pointer; 
var
  iTempTexture : TGDTexture;
begin
  result := nil;
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  iTempTexture := TGDTexture.Create();
  If Not(iTempTexture.InitTexture( aFileName, Settings.TextureDetail,
          Settings.TextureFilter)) then exit;
  result := TextureList.AddObjectP( iTempTexture );
end;

{******************************************************************************}
{* Bind texture to a texture unit                                             *}
{******************************************************************************}

procedure gdTexturesBind(aPointer : pointer; aTextureUnit : TGDTextureUnit ); 
var
  iTempTexture : TGDTexture;
begin
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  iTempTexture := TGDTexture(TextureList.GetObjectP(aPointer));
  If iTempTexture <> nil then
    iTempTexture.BindTexture(aTextureUnit);
  ;
end;

{******************************************************************************}
{* remove a texture in the engine                                             *}
{******************************************************************************}

procedure gdTexturesRemove( aPointer : pointer ); 
begin
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  TextureList.RemoveObjectP(aPointer);
  aPointer := nil
end;

{******************************************************************************}
{* Bind texture to a texture unit                                             *}
{******************************************************************************}

procedure gdTexturesClear(); 
begin
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  TextureList.Clear();
end;

{******************************************************************************}
{* Load a font from a file and return the retrievel index                     *}
{******************************************************************************}

function gdFontsLoad( aFileName : String ) : pointer; 
var
  iTempFont : TGDFont;
begin
  result := nil;
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  iTempFont := TGDFont.Create();
  If Not(iTempFont.InitFont( aFileName )) then exit;
  result := FontList.AddObjectP( iTempFont );
end;

{******************************************************************************}
{* Set the color of a font                                                    *}
{******************************************************************************}

procedure gdFontsSetColor(aPointer : pointer; aR,aG,aB,aA : double); 
var
  iTempFont : TGDFont;
begin
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  iTempFont := TGDFont(FontList.GetObjectP(aPointer));
  If iTempFont <> nil then
    iTempFont.Color := TGDColor.Create(aR,aG,aB,aA)
  ;
end;

{******************************************************************************}
{* Render a text with a font                                                  *}
{******************************************************************************}

procedure gdFontsRenderText(aPointer : pointer; aX,aY,aScale : Double; aText : Pchar); 
var
  iTempFont : TGDFont;
begin
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  iTempFont := TGDFont( FontList.GetObjectP(aPointer));
  If iTempFont <> nil then
    iTempFont.Render(aX,aY,aScale,String(aText))
  ;
end;

{******************************************************************************}
{* Clear all the external fonts in the engine                                 *}
{******************************************************************************}

procedure gdFontsClear(); 
begin
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  FontList.Clear();
end;

{******************************************************************************}
{* remove a fonts in the engine                                               *}
{******************************************************************************}

procedure gdFontsRemove( aPointer : pointer ); 
begin
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  FontList.RemoveObjectP(aPointer);
  aPointer := nil
end;

{******************************************************************************}
{* MainAmbientLight init                                                      *}
{******************************************************************************}

procedure gdMainDirectionalLightSet( aInput : TGDDirectionalLightInput );
begin
  If Not(FEngineInitialized) then exit;
  If Not(FSoundInitialized) then exit;
  DirectionalLight.InitDirectionalLight( aInput );
end;


{******************************************************************************}
{* MainAmbientLight clear                                                     *}
{******************************************************************************}

procedure gdMainDirectionalLightClear();
begin
  If Not(FEngineInitialized) then exit;
  If Not(FSoundInitialized) then exit;
  DirectionalLight.Clear();
end;

{******************************************************************************}
{* Init a soundfile                                                           *}
{******************************************************************************}

function  gdSoundFilesLoad( aFileName : PChar;  aType : TGDSoundTypes  ) : pointer; 
var
  iTempSoundFile : TGDSoundFile;
begin
  result := nil;
  If Not(FEngineInitialized) then exit;
  If Not(FSoundInitialized) then exit;
  iTempSoundFile := TGDSoundFile.Create();
  If Not(iTempSoundFile.InitSoundFile( aFileName, aType )) then exit;
  result := SoundList.AddObjectP( iTempSoundFile );
end;

{******************************************************************************}
{* Clear all soundfiles                                                       *}
{******************************************************************************}

procedure gdSoundFilesClear(); 
begin
  If Not(FEngineInitialized) then exit;
  If Not(FSoundInitialized) then exit;
  SoundList.Clear();
end;

{******************************************************************************}
{* Remove soundfile                                                           *}
{******************************************************************************}

procedure gdSoundFilesRemove( aPointer : pointer ); 
begin
  If Not(FEngineInitialized) then exit;
  If Not(FRendererInitialized) then exit;
  SoundList.RemoveObjectP(aPointer);
  aPointer := nil
end;

{******************************************************************************}
{* Play a soundfile                                                           *}
{******************************************************************************}

procedure gdSoundFilesPlay( aPointer  : pointer ); 
var
  iTempSoundFile : TGDSoundFile;
begin
  If Not(FEngineInitialized) then exit;
  If Not(FSoundInitialized) then exit;
  iTempSoundFile := TGDSoundFile(SoundList.GetObjectP(aPointer));
  If iTempSoundFile <> nil then
    iTempSoundFile.Play();
  ;
end;

{******************************************************************************}
{* Pause a soundfile                                                          *}
{******************************************************************************}

procedure gdSoundFilesPause( aPointer  : pointer ); 
var
  iTempSoundFile : TGDSoundFile;
begin
  If Not(FEngineInitialized) then exit;
  If Not(FSoundInitialized) then exit;
  iTempSoundFile := TGDSoundFile(SoundList.GetObjectP(aPointer));
  If iTempSoundFile <> nil then
    iTempSoundFile.Pause();
  ;
end;

{******************************************************************************}
{* Resume playing of a soundfile                                              *}
{******************************************************************************}

procedure gdSoundFilesResume( aPointer  : pointer ); 
var
  iTempSoundFile : TGDSoundFile;
begin
  If Not(FEngineInitialized) then exit;
  If Not(FSoundInitialized) then exit;
  iTempSoundFile := TGDSoundFile(SoundList.GetObjectP(aPointer));
  If iTempSoundFile <> nil then
    iTempSoundFile.Resume();
  ;
end;

end.