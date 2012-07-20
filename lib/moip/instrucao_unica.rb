require 'nokogiri'

module Moip
  class InstrucaoUnica

    self.make_xml(parameters)
      builder = Nokogiri::XML::Builder.new(:encoding => "UTF-8") do |xml|
        xml.EnviarInstrucao {
            xml.InstrucaoUnica {
               xml.Razao {
                xml.text parameters[:razao]
              }
              xml.Valores {
                xml.Valor(:moeda => "BRL") {
                  xml.text parameters[:valor]
                }
              }
              xml.IdProprio {
                xml.text parameters[:id_proprio]
              }
              
              xml.Pagador {
                xml.Nome { xml.text parameters[:pagador][:nome] }
                xml.LoginMoIP { xml.text parameters[:pagador][:login_moip] }
                xml.Email { xml.text parameters[:pagador][:email] }
                xml.TelefoneCelular { xml.text parameters[:pagador][:tel_cel] }
                xml.Apelido { xml.text parameters[:pagador][:apelido] }
                xml.Identidade(:Tipo => "CPF") { xml.text parameters[:pagador][:identidade] }
                xml.EnderecoCobranca {
                  xml.Logradouro { xml.text parameters[:pagador][:logradouro] }
                  xml.Numero { xml.text parameters[:pagador][:numero] }
                  xml.Complemento { xml.text parameters[:pagador][:complemento] }
                  xml.Bairro { xml.text parameters[:pagador][:bairro] }
                  xml.Cidade { xml.text parameters[:pagador][:cidade] }
                  xml.Estado { xml.text parameters[:pagador][:estado] }
                  xml.Pais { xml.text parameters[:pagador][:pais] }
                  xml.CEP { xml.text parameters[:pagador][:cep] }
                  xml.TelefoneFixo { xml.text parameters[:pagador][:tel_fixo] }
                }
              }
              
              if parameters[:url_retorno]
                # URL de retorno
                xml.URLRetorno {
                  xml.text parameters[:url_retorno]
                }
              end
              
              if !parameters[:comissoes].nil?
                xml.Comissoes {
                  xml.Comissionamento {
                    xml.Razao { xml.text parameters[:comissoes][:razao] }
                    xml.ValorPercentual { xml.text parameters[:comissoes][:valor_percentual] }
                    xml.ValorFixo { xml.text parameters[:comissoes][:valor_fixo] }
                    xml.MostrarParaPagador { xml.text parameters[:comissoes][:mostrar_para_pagador] }
                    xml.Parcelada { xml.text parameters[:comissoes][:parcelada] }
                    xml.Comissionado {
                      xml.LoginMoIP { xml.text parameters[:comissoes][:login_moip] }
                    }
                  }
                } 
              end
              
              if !parameters[:parcelamentos].nil?
                xml.Parcelamentos {
                  xml.Parcelamento {
                    xml.MinimoParcelas { xml.text parameters[:parcelamento][:minimo_parcela] }
                    xml.MaximoParcelas { xml.text parameters[:parcelamento][:maximo_parcela] }
                    xml.Juros { xml.text parameters[:parcelamento][:juros] }
                    xml.Repassar { xml.text parameters[:parcelamento][:repassar] }
                    
                  }
                }
              end
              
            } #xml.InstrucaoUnica
        } #xml.EnviarInstrucao
      end
    end

  end
end
