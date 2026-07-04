const nodemailer = require('nodemailer');

class MailService {
    constructor() {
        this.transporter = null;
    }

    async init() {
        if (process.env.MAIL_USER && process.env.MAIL_PASS) {
            this.transporter = nodemailer.createTransport({
                host: process.env.MAIL_HOST,
                port: parseInt(process.env.MAIL_PORT) || 587,
                secure: false,
                auth: {
                    user: process.env.MAIL_USER,
                    pass: process.env.MAIL_PASS
                }
            });
        } else {
            // Create test account on Ethereal for dev
            const testAccount = await nodemailer.createTestAccount();
            this.transporter = nodemailer.createTransport({
                host: 'smtp.ethereal.email',
                port: 587,
                secure: false,
                auth: {
                    user: testAccount.user,
                    pass: testAccount.pass
                }
            });
            console.log('📧 Mail: Using Ethereal test account:', testAccount.user);
        }
    }

    async send({ to, subject, html, text }) {
        if (!this.transporter) await this.init();
        try {
            const info = await this.transporter.sendMail({
                from: `"Amwaj Almesela" <noreply@amwaj.com>`,
                to,
                subject,
                html: html || text,
                text
            });
            console.log('📧 Mail sent:', info.messageId);
            const previewUrl = nodemailer.getTestMessageUrl(info);
            if (previewUrl) console.log('📧 Preview URL:', previewUrl);
            return info;
        } catch (err) {
            console.error('📧 Mail error:', err.message);
            return null;
        }
    }

    async sendWelcome(user) {
        return this.send({
            to: user.email,
            subject: 'Welcome to Amwaj Almesela!',
            html: `
                <div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;">
                    <h2 style="color: #1b7fed;">Welcome, ${user.name}!</h2>
                    <p>Thank you for registering at Amwaj Almesela. We're excited to have you on board!</p>
                    <p>Start browsing our products and enjoy a seamless shopping experience.</p>
                    <hr>
                    <p style="color: #888; font-size: 12px;">Amwaj Almesela - Building Materials & Equipment</p>
                </div>
            `
        });
    }

    async sendPasswordReset(user, resetUrl) {
        return this.send({
            to: user.email,
            subject: 'Password Reset Request',
            html: `
                <div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;">
                    <h2 style="color: #1b7fed;">Password Reset</h2>
                    <p>You requested a password reset. Click the link below to reset your password:</p>
                    <a href="${resetUrl}" style="display: inline-block; padding: 12px 24px; background: #1b7fed; color: white; text-decoration: none; border-radius: 4px;">Reset Password</a>
                    <p style="margin-top: 20px; color: #666;">This link expires in 10 minutes. If you didn't request this, please ignore this email.</p>
                </div>
            `
        });
    }

    async sendOrderConfirmation(user, order) {
        return this.send({
            to: user.email,
            subject: `Order Confirmed - #${order.order_number}`,
            html: `
                <div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;">
                    <h2 style="color: #1b7fed;">Order Confirmed!</h2>
                    <p>Hi ${user.name}, your order <strong>#${order.order_number}</strong> has been confirmed.</p>
                    <table style="width: 100%; border-collapse: collapse; margin: 20px 0;">
                        <tr style="background: #f5f5f5;"><td style="padding: 8px;">Subtotal</td><td style="padding: 8px; text-align: right;">QAR ${order.subtotal}</td></tr>
                        <tr><td style="padding: 8px;">Shipping</td><td style="padding: 8px; text-align: right;">QAR ${order.shipping_cost}</td></tr>
                        <tr><td style="padding: 8px;">Tax</td><td style="padding: 8px; text-align: right;">QAR ${order.tax}</td></tr>
                        ${order.discount > 0 ? `<tr><td style="padding: 8px; color: green;">Discount</td><td style="padding: 8px; text-align: right; color: green;">-QAR ${order.discount}</td></tr>` : ''}
                        <tr style="background: #1b7fed; color: white;"><td style="padding: 10px; font-weight: bold;">Total</td><td style="padding: 10px; text-align: right; font-weight: bold;">QAR ${order.total}</td></tr>
                    </table>
                    <p>We'll notify you when your order is shipped.</p>
                </div>
            `
        });
    }

    async sendOrderStatusUpdate(user, order) {
        return this.send({
            to: user.email,
            subject: `Order #${order.order_number} - Status Updated`,
            html: `
                <div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;">
                    <h2 style="color: #1b7fed;">Order Status Update</h2>
                    <p>Hi ${user.name}, your order <strong>#${order.order_number}</strong> status has been updated to:</p>
                    <p style="font-size: 20px; font-weight: bold; color: #1b7fed; text-transform: uppercase;">${order.status}</p>
                    ${order.tracking_number ? `<p>Tracking Number: <strong>${order.tracking_number}</strong></p>` : ''}
                </div>
            `
        });
    }

    async sendLowStockAlert(product, inventory) {
        return this.send({
            to: process.env.ADMIN_EMAIL,
            subject: `⚠️ Low Stock Alert: ${product.name}`,
            html: `
                <div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;">
                    <h2 style="color: #e74c3c;">Low Stock Alert</h2>
                    <p>Product <strong>${product.name}</strong> (SKU: ${product.sku || 'N/A'}) is running low on stock.</p>
                    <p>Current Quantity: <strong style="color: #e74c3c;">${inventory.quantity}</strong></p>
                    <p>Threshold: <strong>${inventory.low_stock_threshold}</strong></p>
                    <p>Please restock as soon as possible.</p>
                </div>
            `
        });
    }
}

module.exports = new MailService();
