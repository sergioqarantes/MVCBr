program WooCommerceSample;






  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  {$endif }
  Forms,
  MVCBr.ApplicationController,
  MVCBr.Controller,
  WooCommerceSample.Controller in 'Controllers\WooCommerceSample.Controller.pas',
  WooCommerceSample.Controller.Interf in 'Controllers\WooCommerceSample.Controller.Interf.pas',
  WooCommerceSample.ViewModel.Interf in 'Models\WooCommerceSample.ViewModel.Interf.pas',
  WooCommerceSample.ViewModel in 'ViewModels\WooCommerceSample.ViewModel.pas',
  WooCommerceSampleView in 'Views\WooCommerceSampleView.pas' {WooCommerceSampleView},
  WooCommerce.Model in '..\..\..\3Models\WooCommerce\WooCommerce.Model.pas',
  WooCommerce.Model.Interf in '..\..\..\3Models\WooCommerce\WooCommerce.Model.Interf.pas',
  Rest.OAuth in '..\..\..\3Models\Rest.OAuth.pas';

{$R *.res}










