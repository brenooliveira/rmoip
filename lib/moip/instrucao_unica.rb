module Rmoip
  class InstrucaoUnica

    def self.make_xml(parameters)
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
                  parameters[:comissoes].each do |split|
                    xml.Comissionamento {
                      xml.Razao { xml.text split[:razao] }
                      xml.ValorPercentual { xml.text split[:valor_percentual] }
                      xml.ValorFixo { xml.text split[:valor_fixo] }
                      xml.MostrarParaPagador { xml.text split[:mostrar_para_pagador] }
                      xml.Parcelada { xml.text split[:parcelada] }
                      xml.Comissionado {
                        xml.LoginMoIP { xml.text split[:login_moip] }
                      }
                    }
                  end
                }
              end

              if !parameters[:parcelamentos].nil?
                  xml.Parcelamentos {
                    parameters[:parcelamentos].each do |parcel|
                      xml.Parcelamento {
                        xml.MinimoParcelas { xml.text parcel[:min] }
                        xml.MaximoParcelas { xml.text parcel[:max] }
                        xml.Juros { xml.text parcel[:juros] }
                        xml.Repassar { xml.text parcel[:repassar] }

                      }
                    end
                  }
              end

            } #xml.InstrucaoUnica
        } #xml.EnviarInstrucao
      end
      builder.to_xml
    end

  end
end
