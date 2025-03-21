/* 8) Tabela Funcionário:
a) Crie um campo fundtadmissao para possibilitar o registro do contrato de cada funcionário, do
tipo date;
b) Crie um campo funsexo, do tipo char(1); */

alter table funcionario
add fundtadmissao date;

alter table funcionario
add funsexo char(1);

/* 10) Crie uma nova tabela entregador, que é uma especialização de funcionário; */

create table entregador (
entfuncodigo int not null,
primary key (entfuncodigo),
foreign key (entfuncodigo) references funcionario(funcodigo)
);

/* 11) Relacione a tabela entregador com a tabela venda, garantindo que uma venda não tem
obrigatoriedade de ser entregue, pois o cliente pode comprar na loja. Um entregador pode entregar
várias vendas, mas uma venda só pode ter um entregador. */
 
alter table venda
add venentfuncodigo int,
add foreign key (venentfuncodigo) references entregador (entfuncodigo);

/* 16) Mostre o nome, custo e saldo dos produtos ativos com saldo maior que 5, que foram comprados
por clientes casados e do sexo masculino. */

select distinct pronome nome, 
		procusto custo, prosaldo saldo 
from produto
inner join itemvenda on procodigo = itvprocodigo
inner join venda on vencodigo = itvvencodigo
inner join cliente on clicodigo = venclicodigo
inner join estadocivil on estcodigo = cliestcodigo
where proativo = 1 and prosaldo > 5
and estdescricao = 'casado' and clisexo = 'm'
order by pronome;

/* 27) Mostre os totais dos salários por zona, de todos os funcionários. */ 

select zonnome zona, sum(funsalario) salario 
from funcionario
inner join bairro on baicodigo = funbaicodigo
inner join zona on baizoncodigo = zoncodigo
group by zonnome
-- having sum(funsalario) > 20000
;