import { inject, Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
    providedIn: 'root'
})
export class CartService {
    private http = inject(HttpClient);

    deleteFromCart(item: any): Observable<any> {
        return this.http.delete<any>('/api/cart/delete', {
            body: { nom: item.nom }
        });
    }
}