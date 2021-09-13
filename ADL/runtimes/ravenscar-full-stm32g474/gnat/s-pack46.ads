------------------------------------------------------------------------------
--                                                                          --
--                         GNAT RUN-TIME COMPONENTS                         --
--                                                                          --
--                       S Y S T E M . P A C K _ 4 6                        --
--                                                                          --
--                                 S p e c                                  --
--                                                                          --
--          Copyright (C) 1992-2021, Free Software Foundation, Inc.         --
--                                                                          --
-- GNAT is free software;  you can  redistribute it  and/or modify it under --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 3,  or (at your option) any later ver- --
-- sion.  GNAT is distributed in the hope that it will be useful, but WITH- --
-- OUT ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY --
-- or FITNESS FOR A PARTICULAR PURPOSE.                                     --
--                                                                          --
--                                                                          --
--                                                                          --
--                                                                          --
--                                                                          --
-- You should have received a copy of the GNU General Public License and    --
-- a copy of the GCC Runtime Library Exception along with this program;     --
-- see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see    --
-- <http://www.gnu.org/licenses/>.                                          --
--                                                                          --
-- GNAT was originally developed  by the GNAT team at  New York University. --
-- Extensive contributions were provided by Ada Core Technologies Inc.      --
--                                                                          --
------------------------------------------------------------------------------

--  Handling of packed arrays with Component_Size = 46

package System.Pack_46 is
   pragma Preelaborate;

   Bits : constant := 46;

   type Bits_46 is mod 2 ** Bits;
   for Bits_46'Size use Bits;

   --  In all subprograms below, Rev_SSO is set True if the array has the
   --  non-default scalar storage order.

   function Get_46
     (Arr     : System.Address;
      N       : Natural;
      Rev_SSO : Boolean) return Bits_46 with Inline;
   --  Arr is the address of the packed array, N is the zero-based
   --  subscript. This element is extracted and returned.

   procedure Set_46
     (Arr     : System.Address;
      N       : Natural;
      E       : Bits_46;
      Rev_SSO : Boolean) with Inline;
   --  Arr is the address of the packed array, N is the zero-based
   --  subscript. This element is set to the given value.

   function GetU_46
     (Arr     : System.Address;
      N       : Natural;
      Rev_SSO : Boolean) return Bits_46 with Inline;
   --  Arr is the address of the packed array, N is the zero-based
   --  subscript. This element is extracted and returned. This version
   --  is used when Arr may represent an unaligned address.

   procedure SetU_46
     (Arr     : System.Address;
      N       : Natural;
      E       : Bits_46;
      Rev_SSO : Boolean) with Inline;
   --  Arr is the address of the packed array, N is the zero-based
   --  subscript. This element is set to the given value. This version
   --  is used when Arr may represent an unaligned address

end System.Pack_46;
