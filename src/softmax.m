function [R, AR, QR] =  softmax(tau, X, K)
Q = zeros(1,K);
N = size(X,2);
C = size(X,1);
R = zeros(1,N);
AR = zeros(1,N);
QR = zeros(N,K);
alpha = 0.1;
for t = 1:N
    A = X(:,t,1);
    
    pA = exp(1/tau*Q(A));
    pA = 1/sum(pA)*pA;
    i = find(rand(1) < cumsum(pA));
    a = i(1);
    rew = 0;
    for c = 1:C
        if c==a
            rew = rew + X(c,t,2);
        else
            rew = rew + X(c,t,3);
        end
    end
    Q(A(a)) = Q(A(a))*(1-alpha) + alpha*rew;
    AR(t) = A(a);
    R(t) = rew;
    QR(t,:) = Q;
end