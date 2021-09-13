------------------------------------------------------------------------------
--                                                                          --
--                    Copyright (C) 2015, AdaCore                           --
--                                                                          --
--  Redistribution and use in source and binary forms, with or without      --
--  modification, are permitted provided that the following conditions are  --
--  met:                                                                    --
--     1. Redistributions of source code must retain the above copyright    --
--        notice, this list of conditions and the following disclaimer.     --
--     2. Redistributions in binary form must reproduce the above copyright --
--        notice, this list of conditions and the following disclaimer in   --
--        the documentation and/or other materials provided with the        --
--        distribution.                                                     --
--     3. Neither the name of the copyright holder nor the names of its     --
--        contributors may be used to endorse or promote products derived   --
--        from this software without specific prior written permission.     --
--                                                                          --
--   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS    --
--   "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT      --
--   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR  --
--   A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT   --
--   HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, --
--   SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT       --
--   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,  --
--   DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY  --
--   THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT    --
--   (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE  --
--   OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.   --
--                                                                          --
------------------------------------------------------------------------------

with Ada.Unchecked_Conversion;
with STM32_SVD.RCC; use STM32_SVD.RCC;

package body STM32.RCC is

   function To_AHB1RSTR_T is new Ada.Unchecked_Conversion
     (UInt32, AHB1RSTR_Register);
   function To_AHB2RSTR_T is new Ada.Unchecked_Conversion
     (UInt32, AHB2RSTR_Register);
   function To_AHB3RSTR_T is new Ada.Unchecked_Conversion
     (UInt32, AHB3RSTR_Register);
   function To_APB1RSTR1_T is new Ada.Unchecked_Conversion
     (UInt32, APB1RSTR1_Register);
   function To_APB1RSTR2_T is new Ada.Unchecked_Conversion
     (UInt32, APB1RSTR2_Register);
   function To_APB2RSTR_T is new Ada.Unchecked_Conversion
     (UInt32, APB2RSTR_Register);

   ---------------------------------------------------------------------------
   -------  Enable/Disable/Reset Routines  -----------------------------------
   ---------------------------------------------------------------------------

   procedure AHB_Force_Reset is
   begin
      RCC_Periph.AHB1RSTR := To_AHB1RSTR_T (16#FFFF_FFFF#);
      RCC_Periph.AHB2RSTR := To_AHB2RSTR_T (16#FFFF_FFFF#);
      RCC_Periph.AHB3RSTR := To_AHB3RSTR_T (16#FFFF_FFFF#);
   end AHB_Force_Reset;

   procedure AHB_Release_Reset is
   begin
      RCC_Periph.AHB1RSTR := To_AHB1RSTR_T (0);
      RCC_Periph.AHB2RSTR := To_AHB2RSTR_T (0);
      RCC_Periph.AHB3RSTR := To_AHB3RSTR_T (0);
   end AHB_Release_Reset;

   procedure APB1_Force_Reset is
   begin
      RCC_Periph.APB1RSTR1 := To_APB1RSTR1_T (16#FFFF_FFFF#);
      RCC_Periph.APB1RSTR2 := To_APB1RSTR2_T (16#FFFF_FFFF#);
   end APB1_Force_Reset;

   procedure APB1_Release_Reset is
   begin
      RCC_Periph.APB1RSTR1 := To_APB1RSTR1_T (0);
      RCC_Periph.APB1RSTR2 := To_APB1RSTR2_T (0);
   end APB1_Release_Reset;

   procedure APB2_Force_Reset is
   begin
      RCC_Periph.APB2RSTR := To_APB2RSTR_T (16#FFFF_FFFF#);
   end APB2_Force_Reset;

   procedure APB2_Release_Reset is
   begin
      RCC_Periph.APB2RSTR := To_APB2RSTR_T (0);
   end APB2_Release_Reset;

end STM32.RCC;
