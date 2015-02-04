%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ��˹�����˲���
% �˲����Ĵ��ݺ���ΪH(u,v)=1-exp(-1/2*((D^2-D0^2)/(D*W))^2)
% ����W��Ƶ������,D0��Ƶ�������İ뾶
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ImgOut=BandFilter(ImgIn,d0,W)
s=fftshift(fft2(ImgIn));               %���Ҷ�ͼ��Ķ�ά������Frourier�任����Ƶ�ʳɷ��Ƶ�Ƶ�׵�����
[M,N]=size(s);                      %�ֱ𷵻�s��������M�У�������N��
n1=floor(M/2)+1;                    %��M/2����ȡ��
n2=floor(N/2)+1;                    %��N/2����ȡ��
for i=1:M
    for j=1:N
        d=sqrt((i-n1)^2+(j-n2)^2);         %�㣨i,j��������Ҷ�任���ĵľ���
        h=exp(-1/2*((d^2-d0^2)/(d*W))^2);%GBEF�˲�����
        s1(i,j)=h*s(i,j);                   %GBEF�˲����Ƶ���ʾ
        H(i,j)=h;
    end
end
figure;
subplot(1,3,1),imshow(log(abs(s)+1),[]);title('�˲�ǰͼ����ҶƵ��ȡ����');
subplot(1,3,2),imshow(log(abs(s1)+1),[]);title('�˲���ͼ����ҶƵ��ȡ����');
subplot(1,3,3),mesh(H);title('�˲���Ƶ��ͼ');
s=ifftshift(s1);                           %��s���з�FFT�ƶ�
%��s���ж�ά����ɢ��Fourier�任��ȡ������ʵ��ת��Ϊ�޷���8λ����
s=uint8(real(ifft2(s)));
ImgOut=s;