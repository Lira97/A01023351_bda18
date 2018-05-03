
public class BplusTree{
	private Integer valor1;
	private Integer valor2; 

	private BplusTree padre; 
	private BplusTree hijoIzq;
	private BplusTree hijoCent;
	private BplusTree hijoDer;

	private BplusTree sigNum;

	private bool leaf;
	
	public BplusTree(){
		this.valor1 = null;
		this.valor2 = null; 
		this.leaf = true;
	}

	public bool getleaf(){
		return leaf;
	}

	public BplusTree getHijoCent(){
		return hijoCent;
	}

	public void setHijoCent(BplusTree a){
		this.hijoCent = a;
	}

	public void setleaf(bool leaf){
		this.leaf = leaf;
	}

	public Integer getValor1(){
		return valor1;
	}

	public void setValor1(Integer valor){
		this.valor1 = valor;
	}

	public Integer getValor2(){
		return valor2;
	}

	public void setValor2(Integer valor){
		this.valor2 = valor;
	}

	public BplusTree getPadre(){
		return padre;
	}

	public void setPadre(BplusTree padre){
		this.padre = padre;
	}

	public BplusTree gethijoIzq(){
		return hijoIzq;
	}

	public void sethijoIzq(BplusTree hijoIzq){
		this.hijoIzq = hijoIzq;
	}

	public BplusTree gethijoDer(){
		return hijoDer;
	}

	public void sethijoDer(BplusTree hijoDer){
		this.hijoDer = hijoDer;
	}

	public BplusTree getsigNum(){
		return sigNum;
	}

	public void setSigNum(BplusTree sigNum){
		this.sigNum = sigNum;
	}

	public void newNum(Integer num, BplusTree a){
		
		if (a.getleaf() != true){
			if ( num < a.getValor1() && a.getValor1() == null)
			{
				newNum(num, a.gethijoIzq());
			} 
			else if (a.getValor2() < num )
			{
				newNum(num, a.gethijoDer());
			}           
			else if (a.getValor1() < num && num < a.getValor2())
			{
				newNum(num, a.getHijoCent());
			}
		}
		else
		{
			compVal(num, a);
		}    
	}

	public void compVal(Integer num, BplusTree a){

	   Integereger n = num; 

		Integereger i = a.getValor1();
		Integereger d = a.getValor2();

		if (l == null){
			a.setValor1(n);
		}
		else if (n < i && d == null){
			a.setValor2(a.getValor1());
			a.setValor1(n);
		}
		else if (n > i && d == null){
			a.setValor2(n);
		}
		else if (i != null && d != null)
		{
			if ( n < i ){
				BplusTree temp = new BplusTree();
				temp.setValor1(i);
				temp.setValor2(d);
				a.setValor1(n);
				a.setValor2(null);
			}
			else if( i < n && n < d){
				temp.setValor1(n);
				temp.setValor2(d); 
				a.setValor1(i);
				a.setValor2(null);
			}
			else if ( d < n){
				temp.setValor1(d);
				temp.setValor2(n);
				a.setValor1(i);
				a.setValor2(null);
			}

			temp.setSigNum(a.getSigNum());
			a.setSigNum(temp);
			modPadre(n, a, temp);
		}

	}

	public void modPadre(Integer n, BplusTree a, BplusTree b){

		if (a.getPadre() == null){
			BplusTree padre = new BplusTree();
			padre.sethijoIzq(a);
			padre.sethijoDer(b);
			padre.setValor1(n);
			padre.setleaf(false);

			a.setPadre(padre);
			b.setPadre(padre);
		}
		else
		{
			if(a.getPadre().getValor1() < n && a.getPadre().getValor1() == null){
				a.getPadre().setValor2(a.getpadre.getValor1());
				a.getPadre().setValor1(n);
				puntHij(a, b);
			}
			else if(a.getPadre().getValor1() > n && a.getPadre().getValor1() == null){
				a.getPadre().setValor2(n);
				puntHij(a, b);
			}
			else if (a.getPadre().getValor2() != null ){
				sendPadre(a.getPadre(), n);
			}
		}
	}

	public void puntHij(BplusTree a, BplusTree b){
		if (a.getPadre().gethijoIzq() == a){
			a.getPadre().setHijoCent(b);
			b.setPadre(a.getPadre());
		}
		else if(a.getPadre().gethijoDer() == a){
			a.getPadre().setHijoCent(a);
			a.getPadre().sethijoDer(b);
			b.setPadre(a.getPadre());
		}
	}


	public void sendPadre(BplusTree a, Integer n){

		if (a.getPadre() == null){
			BplusTree newPadre = new BplusTree();
			newPadre.setleaf(false);
			BplusTree secHij = new BplusTree();
			secHij.setleaf(false);

			a.setPadre(newPadre);
			if (a.getValor1() > n){
				newPadre.setValor1(a.getValor1());
				a.setValor1(n);
				secHij.setValor1(a.getValor2());
				a.setValor2(null);
				newPadre.sethijoIzq(a);
				newPadre.sethijoDer(secHij);
				a.setPadre(newPadre);
				secHij.setPadre(newPadre);
			}
			else if(a.getValor1() < n && a.getValor2() > n){
				newPadre.setValor1(n);
				secHij.setValor1(a.getValor2());
				a.setValor2(null);
				newPadre.sethijoIzq(a);
				newPadre.sethijoDer(secHij);
				a.setPadre(newPadre);
				secHij.setPadre(newPadre);
			}
			else if(a.getValor2() < n){
				newPadre.setValor1(a.getValor2());
				secHij.setValor1(n);
				a.setValor2(null);
				newPadre.sethijoIzq(a);
				newPadre.sethijoDer(secHij);
				a.setPadre(newPadre);
				secHij.setPadre(newPadre);
			}
		}
		else{
			if(a.getPadre().getValor2() != null){
				sendPadre(a.getPadre(), n);
			}
			a.getPadre().setValor2(n);
		}
	}

   /* public void imprimir(BplusTree a){
		if (a.getleaf())
	}*/

	public void main(String[] args){
		
	}
}