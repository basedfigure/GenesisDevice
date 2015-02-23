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
unit GDBaseCell;

{$MODE Delphi}

{******************************************************************************}
{* Holds the base cell class                                                  *}
{******************************************************************************}

interface

uses
  SysUtils,
  GDConstants,
  GDBoundingVolumes;

type

{******************************************************************************}
{* Base cell class                                                            *}
{******************************************************************************}

  TGDBaseCell = class (TObject)
  private
    FBoundingBox    : TGDBoundingBox;
    FObjectType     : TGDStaticObjectType;
    FDistance       : Double;
  public
    property BoundingBox : TGDBoundingBox read FBoundingBox write FBoundingBox;
    property OjectType   : TGDStaticObjectType read FObjectType write FObjectType;
    property Distance    : Double read FDistance write FDistance;

    constructor Create();
    destructor  Destroy(); override;
  end;

implementation

{******************************************************************************}
{* Create the base cell class                                                 *}
{******************************************************************************}

constructor TGDBaseCell.Create();
begin
  FBoundingBox    := TGDBoundingBox.Create();
  FObjectType     := SO_NONE;
  FDistance       := 0;
end;

{******************************************************************************}
{* Destroy the base cell class                                                *}
{******************************************************************************}

destructor  TGDBaseCell.Destroy();
begin
  FreeAndNil(FBoundingBox);
end;


end.