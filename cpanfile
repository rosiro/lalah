requires 'Amon2'                           => '3.74';
requires 'Text::Xslate'                    => '1.6001';
requires 'Module::Functions'               => '2';

on 'configure' => sub {
   requires 'Module::Build'     => '0.38';
   requires 'Module::CPANfile' => '0.9010';
};

on 'test' => sub {
   requires 'Test::More'     => '0.98';
};
