//
//  ViewController.m
//  tcpDemo
//
//  Created by lh on 16/4/21.
//  Copyright © 2016年 Lh. All rights reserved.
//

#import "ViewController.h"
#import "GCDAsyncSocket.h"

@interface ViewController () <GCDAsyncSocketDelegate>
@property (weak, nonatomic) IBOutlet UITextField *ipTf;
@property (weak, nonatomic) IBOutlet UITextField *hostTf;
@property (weak, nonatomic) IBOutlet UITextField *messageTf;
@property (weak, nonatomic) IBOutlet UIButton *connectBtn;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
- (IBAction)connect:(UIButton *)sender;
- (IBAction)send:(UIButton *)sender;

@property (nonatomic, strong)GCDAsyncSocket *socket;
@property (nonatomic, strong)NSData *readData;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)connect:(UIButton *)sender {
    
    if ([self.ipTf.text length] == 0 || [self.hostTf.text length] == 0) {
        return;
    }
    
    NSError *error = nil;
    
    NSString *port = self.hostTf.text;
    
    [self.socket connectToHost:self.ipTf.text onPort:[port  integerValue]  error:&error];
    if (error != nil) {
        NSLog(@"%@", error);
    }
}

- (GCDAsyncSocket *)socket
{
    if (_socket == nil) {
        _socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    }
    
    return _socket;
}

- (IBAction)send:(UIButton *)sender {
    if ( [self.messageTf.text length] == 0) {
        return;
    }
    
    NSData *data = [self.messageTf.text dataUsingEncoding:NSUTF8StringEncoding];
    
    [self.socket writeData:data withTimeout:-1 tag:0];
    
    [self.socket readDataToData:[GCDAsyncSocket CRLFData] withTimeout:5 tag:0];
}
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{
    NSLog(@"connect : host = %@  port = %d", host, port);
    
  //  self.ipTf.enabled = NO;
   // self.hostTf.enabled = NO;
}

- (void)socket:(GCDAsyncSocket *)sock didReadPartialDataOfLength:(NSUInteger)partialLength tag:(long)tag
{
    NSLog(@"");
}


- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"rec from server:%@", string);
}
@end
