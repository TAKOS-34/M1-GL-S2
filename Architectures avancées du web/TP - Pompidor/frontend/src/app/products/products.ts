import { Component, inject, signal } from '@angular/core';
import { Router } from '@angular/router';
import { ProductsService } from '../shared/products.service';

@Component({
  selector: 'app-products',
  standalone: true,
  templateUrl: './products.html'
})
export class Products {
  private service = inject(ProductsService);
  private router = inject(Router);
  products = signal<any[]>([]);
  quantities = signal<Record<string, number>>({});

  ngOnInit() {
    this.service.getProducts().subscribe(data => {
      this.products.set(data);
    });
  }

  getQuantity(productName: string): number {
    return this.quantities()[productName] ?? 1;
  }

  increment(productName: string) {
    const current = this.getQuantity(productName);
    this.quantities.update(q => ({ ...q, [productName]: current + 1 }));
  }

  decrement(productName: string) {
    const current = this.getQuantity(productName);
    this.quantities.update(q => ({ ...q, [productName]: Math.max(1, current - 1) }));
  }

  addProductToCart(product: any) {
    const quantity = this.getQuantity(product.nom);
    this.service.addToCart(product, quantity).subscribe(() => {
      this.router.navigate(['/cart']);
    });
  }
}
