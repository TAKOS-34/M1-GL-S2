import { inject, Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ProductsService {
  private http = inject(HttpClient);

  getProducts(): Observable<any[]> {
    return this.http.get<any[]>('/api/articles');
  }

  addToCart(product: any, quantity: number): Observable<any> {
    return this.http.post<any>('/api/cart/add', {
      nom: product.nom,
      quantity
    });
  }

  getCart(): Observable<any[]> {
    return this.http.get<any[]>('/api/cart');
  }
}