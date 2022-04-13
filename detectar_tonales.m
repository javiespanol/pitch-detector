function [tonalidad] = detectar_tonales(audio)

    % Función que devuelve Verdadero en caso de señal tonal, o devuelve 
    % Falso en caso de señal no tonal
    % Parametros de entrada:
    %   audio = nombre del audio a analizar para decidir si es tonal o no
    % Parametros de salida:
    %   tonalidad = Verdadero si es tonal, Falso en otro caso

    [senal,fs]=audioread(audio);
    senal = senal(:,1);                                                         %Nos quedamos con el primer canal, en caso de que sea un audio estéreo

    [x] = ver_espectro_modificada(senal,'hamming',2048,fs);                     %Utilizamos la funcion para conseguir la DFT
    x = smoothdata(x);                                                          %Eliminamos los máximos poco pronunciados
    x = smoothdata(x);                                                          %Eliminamos los máximos poco pronunciados

    M = mean(x);                                                                %Conseguimos la media para establecer un corte inferior
    TF = islocalmax(x,'MinProminence',M/2);                                     %Conseguimos los puntos en los que hay máximos
    numero_de_tonos=sum(TF(:) == 1);                                            %Contabilizamos los máximos

    if numero_de_tonos==0                                                       %Si el número de tonos es mayor o igual a 1, sería una señal tonal                          
       tonalidad="Falso";
    else
       tonalidad="Verdadero";
    end
    
end