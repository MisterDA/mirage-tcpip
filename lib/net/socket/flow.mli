(*
 * Copyright (c) 2011 Anil Madhavapeddy <anil@recoil.org>
 *
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *)


open Nettypes

type ipv4_src = ipv4_addr option * int
type ipv4_dst = ipv4_addr * int

module TCPv4 : sig
  type t
  type mgr = Manager.t
  type src = ipv4_src
  type dst = ipv4_dst

  val read : t -> OS.Istring.View.t option Lwt.t
  val write : t -> OS.Istring.View.t -> unit Lwt.t
  val close : t -> unit Lwt.t

  val listen : mgr -> src -> (dst -> t -> unit Lwt.t) -> unit Lwt.t
  val connect : mgr -> src -> dst -> (t -> unit Lwt.t) -> unit Lwt.t
end

module UDPv4 : sig
  type mgr = Manager.t

  type src = ipv4_src
  type dst = ipv4_dst

  type msg = OS.Istring.View.t
 
  val recv : mgr -> src -> (dst -> msg -> unit Lwt.t) -> unit Lwt.t
  val send : mgr -> dst -> msg -> unit Lwt.t
end
