import { Component, inject, signal } from '@angular/core';
import { CartService } from '../shared/cart.service';
import { ProductsService } from '../shared/products.service';

@Component({
  selector: 'app-cart',
  standalone: true,
  templateUrl: './cart.html'
})
export class Cart {
  private cartService = inject(CartService);
  private service = inject(ProductsService);
  items = signal<any[]>([]);

  ngOnInit() {
    this.service.getCart().subscribe(data => {
      this.items.set(data);
    });
  }

  deleteFromCart(item: any) {
    this.cartService.deleteFromCart(item).subscribe(_ => {
      window.location.reload();
    });
  }
}
