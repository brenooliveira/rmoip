module Rmoip
  class InstrucaoUnica
    include Commons

    def valid?
      # TODO implement this
      true
    end

    def pagador(&block)
      @pagador ||= Pagador.new(&block)
    end

    def to_xml
      Nokogiri::XML::Builder.new(:encoding => "UTF-8") do |xml|
        xml.EnviarInstrucao {
          xml.InstrucaoUnica {
            xml.Razao razao
            xml.Pagador {
              xml.Nome pagador.nome
            }
          }
        }
      end.to_xml

    end

    def hash
      {
        :EnviarInstrucao => {
          :InstrucaoUnica => {
            :Razao => razao
          }
        }
      }
    end


    def self.make_xml(parameters)
      builder = Nokogiri::XML::Builder.new(:encoding => "UTF-8") do |xml|
        xml.EnviarInstrucao {
            xml.InstrucaoUnica {
               xml.Razao {
                xml.text parameters[:reason]
              }
              xml.Valores {
                xml.Valor(:moeda => "BRL") {
                  xml.text parameters[:value]
                }
              }
              xml.IdProprio {
                xml.text parameters[:unique_id]
              }

              xml.payer {
                xml.Nome { xml.text parameters[:payer][:nome] }
                xml.LoginMoIP { xml.text parameters[:payer][:login_moip] }
                xml.PagadorId{ xml.text parameters[:payer][:payer_id] }
                xml.Email { xml.text parameters[:payer][:email] }
                xml.TelefoneCelular { xml.text parameters[:payer][:mobile_phone] }
                xml.Apelido { xml.text parameters[:payer][:nickname] }
                xml.Identidade(:Tipo => "CPF") { xml.text parameters[:payer][:identity] }
                xml.EnderecoCobranca {
                  xml.Logradouro { xml.text parameters[:payer][:street] }
                  xml.Numero { xml.text parameters[:payer][:number] }
                  xml.Complemento { xml.text parameters[:payer][:complement] }
                  xml.Bairro { xml.text parameters[:payer][:neighborhood] }
                  xml.Cidade { xml.text parameters[:payer][:city] }
                  xml.Estado { xml.text parameters[:payer][:state] }
                  xml.Pais { xml.text parameters[:payer][:country] }
                  xml.CEP { xml.text parameters[:payer][:zipcode] }
                  xml.TelefoneFixo { xml.text parameters[:payer][:phone] }
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
                      xml.Razao { xml.text split[:reason] }
                      xml.ValorPercentual { xml.text split[:valor_percentual] }
                      xml.ValorFixo { xml.text split[:valor_fixo] }
                      xml.MostrarParapayer { xml.text split[:show_for_payer] }
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
                        xml.Juros { xml.text parcel[:nterest] }
                        xml.Repassar { xml.text parcel[:transfer] }

                      }
                    end
                  }
              end

            } #xml.InstrucaoUnica
        } #xml.EnviarInstrucao

        if (parameters[:validate])
          xml.InstrucaoUnica(:TipoValidacao => "Transparente")
        end
      end
      builder.to_xml
    end

    private

    def valid_attr
      [ :razao, :id_proprio, :valor, :pagador ]
    end

  end
end
