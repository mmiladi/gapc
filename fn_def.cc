/* {{{

    This file is part of gapc (GAPC - Grammars, Algebras, Products - Compiler;
      a system to compile algebraic dynamic programming programs)

    Copyright (C) 2008-2011  Georg Sauthoff
         email: gsauthof@techfak.uni-bielefeld.de or gsauthof@sdf.lonestar.org

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

}}} */


#include "fn_def.hh"

#include "statement.hh"
#include "expr.hh"

#include "log.hh"

#include "product.hh"

#include "para_decl.hh"

#include "type/multi.hh"

#include <cassert>

Fn_Def::Fn_Def(Fn_Def &a, Fn_Def &b)
  : adaptor(NULL),
    choice_fn_type_(Expr::Fn_Call::NONE)
{
  //assert(a.in_use() == b.in_use());
  set_in_use(a.in_use() || b.in_use());
  choice_fn = a.choice_fn;
  if (choice_fn) {
    Type::Base *x = 0;
    if (a.return_type->is(Type::LIST))
      x = dynamic_cast<Type::List*>(a.return_type->simple())->of->simple();
    else
      x = a.return_type->simple();

    Type::Base *y = 0;
    if (b.return_type->is(Type::LIST))
      y = dynamic_cast<Type::List*>(b.return_type->simple())->of->simple();
    else
      y = b.return_type->simple();

    Type::List *l = new Type::List(new Type::Tuple(x, y));
    return_type = l;
    types.push_back(l);
    names = a.names;
    name = a.name;

    assert(!names.empty());
    paras.push_back(new Para_Decl::Simple(l, names.front()));
    return;
  }

  return_type = new Type::Tuple(a.return_type, b.return_type);

  std::list<Para_Decl::Base*>::iterator j = b.paras.begin();
  for (std::list<Para_Decl::Base*>::iterator i = a.paras.begin();
      i != a.paras.end(); ++i, ++j) {
    Para_Decl::Simple *p = dynamic_cast<Para_Decl::Simple*>(*i);
    if (p) {
      Para_Decl::Simple *u = dynamic_cast<Para_Decl::Simple*>(*j);
      assert(u);

      assert(p->type()->is_terminal() == u->type()->is_terminal());
      if (p->type()->is_terminal()) {
        assert(p->type()->is_eq(*u->type()));
        types.push_back(p->type());
        std::string *n = new std::string("p_" + *p->name());
        names.push_back(n);
        paras.push_back(new Para_Decl::Simple(p->type(), n));
      } else  {
        Type::Base *t = new Type::Tuple(p->type(), u->type());
        types.push_back(t);
        std::string *n = new std::string("p_" + *p->name());
        names.push_back(n);
        paras.push_back(new Para_Decl::Simple(t, n));
      }
    } else {
      Para_Decl::Multi *p = dynamic_cast<Para_Decl::Multi*>(*i);
      assert(p);
      Para_Decl::Multi *u = dynamic_cast<Para_Decl::Multi*>(*j);
      assert(u);

      std::list<Para_Decl::Simple*> s;

      std::list<Type::Base*> l;
      std::list<Para_Decl::Simple*>::const_iterator b = u->list().begin();
      for (std::list<Para_Decl::Simple*>::const_iterator a = p->list().begin();
          a != p->list().end(); ++a, ++b)
        if ((*a)->type()->is_terminal()) {
          assert((*a)->type()->is_eq(*(*b)->type()));
          l.push_back((*a)->type());
          s.push_back(new Para_Decl::Simple((*a)->type(),
                new std::string("p_" + *(*a)->name())));
        } else {
          Type::Base *t = new Type::Tuple((*a)->type(), (*b)->type());
            l.push_back(t);
          s.push_back(new Para_Decl::Simple(t,
                new std::string("p_" + *(*a)->name())));
        }
      Type::Base *t = new Type::Multi(l);
      types.push_back(t);
      std::string *n = new std::string("p_MULTI");
      names.push_back(n);
      paras.push_back(new Para_Decl::Multi(s));
    }
  }

  name = a.name;

  assert(a.ntparas_.size() == b.ntparas_.size());
  assert(a.nttypes_.size() == b.nttypes_.size());
  ntparas_ = a.ntparas_;
  nttypes_= a.nttypes_;
}

#include <sstream>

Fn_Def::Fn_Def(const Fn_Decl &other)
  : Fn_Decl()
{
  return_type = other.return_type;
  types = other.types;
  name = other.name;
  choice_fn = other.is_Choice_Fn();
  adaptor = NULL;
  std::string pref("param_");
  for (unsigned int i = 0; i < types.size(); i++) {
    std::ostringstream o;
    o << pref << i;
    names.push_back(new std::string(o.str()));
  }

  std::list<std::string*>::iterator j = names.begin();
  for (std::list<Type::Base*>::iterator i = types.begin();
       i != types.end(); ++i, ++j) {
    if ((*i)->is(Type::MULTI)) {
      Type::Multi *m = dynamic_cast<Type::Multi*>(*i);
      std::list<Para_Decl::Simple*> l;
      unsigned track = 0;
      for (std::list<Type::Base*>::const_iterator k = m->types().begin();
           k != m->types().end(); ++k, ++track) {
        std::ostringstream o;
        o << **j << "_" << track;
        l.push_back(new Para_Decl::Simple(*k, new std::string(o.str())));
      }
      paras.push_back(new Para_Decl::Multi(l));
    } else {
      paras.push_back(new Para_Decl::Simple(*i, *j));
    }
  }

  nttypes_ = other.nttypes();
  unsigned a = 0;
  for (std::list<Type::Base*>::iterator i = nttypes_.begin();
       i != nttypes_.end(); ++i, ++a) {
    std::ostringstream o;
    o << "ntp_" << a;
    ntparas_.push_back(new Para_Decl::Simple(*i, new std::string(o.str())));
  }
}

void Fn_Def::set_paras(const std::list<Para_Decl::Base*> &l)
{
  paras.insert(paras.end(), l.begin(), l.end());
  for (std::list<Para_Decl::Base*>::const_iterator i = l.begin();
       i != l.end(); ++i) {
    Para_Decl::Simple *p = dynamic_cast<Para_Decl::Simple*>(*i);

    if (!p) {
      Para_Decl::Multi *m = dynamic_cast<Para_Decl::Multi*>(*i);
      assert(m);

      types.push_back(m->type());
      names.push_back(new std::string("MULTI"));

      continue;
    }
    types.push_back(p->type());
    names.push_back(p->name());
    hashtable<std::string, Type::Base*>::iterator j =
      parameters.find(*p->name());
    if (j != parameters.end())
      Log::instance()->error(p->location(),
          "Parameter redefined in definition of function"
          + *name + ".");
    else
      parameters[*p->name()] = p->type();
  }
}

void Fn_Def::annotate_terminal_arguments(Fn_Decl &d)
{
  assert(types_equal(d));

  std::list<Type::Base*>::iterator j = types.begin();
  for (std::list<Type::Base*>::iterator i = d.types.begin();
      i != d.types.end() && j != types.end(); ++i, ++j) {
    if ((*i)->is_terminal())
      (*j)->set_terminal();
    if ((*i)->is(Type::MULTI)) {
      Type::Multi *a = dynamic_cast<Type::Multi*>(*i);
      assert(a);
      Type::Multi *b = dynamic_cast<Type::Multi*>(*j);
      assert(b);
      std::list<Type::Base*>::const_iterator l = b->types().begin();
      for (std::list<Type::Base*>::const_iterator k = a->types().begin();
          k != a->types().end(); ++k, ++l)
        if ((*k)->is_terminal()) {
          (*l)->set_terminal();
        }
    }
  }
}

void Fn_Def::add_para(Type::Base *type, std::string *n)
{
  names.push_back(n);
  types.push_back(type);
  hashtable<std::string, Type::Base*>::iterator i =
    parameters.find(*n);
  if (i != parameters.end())
    std::cerr << "Parameter already there: " << *n << '\n';
  assert(i == parameters.end());
  parameters[*n] = type;
  paras.push_back(new Para_Decl::Simple(type, n));
}

void Fn_Def::add_paras(const std::list<Statement::Var_Decl*> &l)
{
  for (std::list<Statement::Var_Decl*>::const_iterator i = l.begin(); i != l.end();
       ++i)
    add_para((*i)->type, (*i)->name);
}

#include "symbol.hh"
#include "expr/vacc.hh"
#include "var_acc.hh"

void Fn_Def::add_para(Symbol::NT &nt)
{
  Type::Base *t = new Type::Size();

  const std::vector<Table> &tables = nt.tables();
  std::vector<Expr::Base*> &left = nt.left_indices;
  std::vector<Expr::Base*> &right = nt.right_indices;

  std::vector<Expr::Base*>::iterator j = left.begin();
  std::vector<Expr::Base*>::iterator k = right.begin();
  for (std::vector<Table>::const_iterator i = tables.begin(); i != tables.end();
       ++i, ++j, ++k) {
    if (!(*i).delete_left_index())
      add_para(t, (*j)->vacc()->name());
    if (!(*i).delete_right_index())
      add_para(t, (*k)->vacc()->name());
  }

  set_paras(nt.ntargs());
}

void Fn_Def::set_statements(const std::list<Statement::Base*> &l)
{
  stmts = l;
}

void Fn_Def::init_var_decl(Para_Decl::Simple *a, Para_Decl::Simple *b,
    Para_Decl::Simple *c,
    const std::string &o1, const std::string &o2)
{
    Statement::Var_Decl *v =
      new Statement::Var_Decl(a->type(), new std::string(o1));
    Statement::Var_Decl *w =
      new Statement::Var_Decl(b->type(), new std::string(o2));
    Type::Base *type = c->type();
    if (type->is_terminal()) {
      v->set_rhs(new Expr::Vacc(c->name()));
      w->set_rhs(new Expr::Vacc(c->name()));
    } else {
      Type::Tuple *t = dynamic_cast<Type::Tuple*>(type->simple());
      assert(t);
      assert(t->list.size() == 2);
      std::list<std::pair<Type::Name*, std::string*>*>::iterator list =
        t->list.begin();
      std::pair<Type::Name*, std::string*> *lname = *list;
      ++list;
      std::pair<Type::Name*, std::string*> *rname = *list;
      v->set_rhs(new Expr::Vacc(c->name(), lname->second));
      w->set_rhs(new Expr::Vacc(c->name(), rname->second));
    }
    v_list.push_back(v);
    w_list.push_back(w);
}

void Fn_Def::init_var_decls(Fn_Def &a, Fn_Def &b)
{
  assert(a.paras.size() == b.paras.size());
  assert(a.paras.size() == paras.size());
  unsigned int z = 0;
  std::list<Para_Decl::Base*>::iterator x = paras.begin();
  std::list<Para_Decl::Base*>::iterator j = b.paras.begin();
  for (std::list<Para_Decl::Base*>::iterator i = a.paras.begin();
      i != a.paras.end(); ++i, ++j, ++x, ++z) {
    Para_Decl::Simple *p = dynamic_cast<Para_Decl::Simple*>(*i);
    if (p) {
      Para_Decl::Simple *u = dynamic_cast<Para_Decl::Simple*>(*j);
      assert(u);
      Para_Decl::Simple *v = dynamic_cast<Para_Decl::Simple*>(*x);
      assert(v);

      std::ostringstream o1;
      o1 << "l_" << z;
      std::ostringstream o2;
      o2 << "r_" << z;
      init_var_decl(p, u, v, o1.str(), o2.str());
    } else {
      Para_Decl::Multi *p = dynamic_cast<Para_Decl::Multi*>(*i);
      assert(p);
      Para_Decl::Multi *u = dynamic_cast<Para_Decl::Multi*>(*j);
      assert(u);
      Para_Decl::Multi *v = dynamic_cast<Para_Decl::Multi*>(*x);
      assert(v);

      unsigned y = 0;
      std::list<Para_Decl::Simple*>::const_iterator m = v->list().begin();
      std::list<Para_Decl::Simple*>::const_iterator l = u->list().begin();
      for (std::list<Para_Decl::Simple*>::const_iterator k = p->list().begin();
          k != p->list().end(); ++k, ++l, ++m, ++y) {
        std::ostringstream o1;
        o1 << "l_" << z << "_" << y;
        std::ostringstream o2;
        o2 << "r_" << z << "_" << y;
        init_var_decl(*k, *l, *m, o1.str(), o2.str());
      }

    }
  }

}

void Fn_Def::codegen()
{
  init_range_iterator();
}

void Fn_Def::codegen(Fn_Def &a, Fn_Def &b, Product::Two &product)
{
  assert(stmts.empty());
  if (choice_fn) {
    codegen_choice(a, b, product);
    return;
  }

  init_var_decls(a, b);
  stmts.insert(stmts.end(), v_list.begin(), v_list.end());
  stmts.insert(stmts.end(), w_list.begin(), w_list.end());
  Expr::Fn_Call *left_fn = new Expr::Fn_Call(new std::string(a.target_name()));
  Expr::Fn_Call *right_fn = new Expr::Fn_Call(new std::string(b.target_name()));
  std::list<Statement::Var_Decl*>::iterator j = w_list.begin();
  for (std::list<Statement::Var_Decl*>::iterator i = v_list.begin();
      i != v_list.end() && j != w_list.end(); ++i, ++j) {
    left_fn->add_arg(**i);
    right_fn->add_arg(**j);
  }

  left_fn->add(a.ntparas_);
  right_fn->add(a.ntparas_);

  Statement::Var_Decl *ret_left =
    new Statement::Var_Decl(a.return_type,
        new std::string("ret_left"), left_fn);
  stmts.push_back(ret_left);
  Statement::Var_Decl *ret_right =
    new Statement::Var_Decl(b.return_type,
        new std::string("ret_right"), right_fn);
  stmts.push_back(ret_right);
  Statement::Var_Decl *ret = new Statement::Var_Decl(return_type,
      new std::string("ret"));
  stmts.push_back(ret);
  Statement::Var_Assign *left_ass =
    new Statement::Var_Assign(ret->left(), *ret_left);
  stmts.push_back(left_ass);
  Statement::Var_Assign *right_ass =
    new Statement::Var_Assign(ret->right(), *ret_right);
  stmts.push_back(right_ass);
  Statement::Return *r = new Statement::Return(*ret);
  stmts.push_back(r);
}

void Fn_Def::init_fn_suffix(const std::string &s)
{
  target_name_ = *name + s;
}

void Fn_Def::init_range_iterator()
{
  adaptor = new Fn_Def(*this);
  adaptor->name = name;
  adaptor->names = names;
  adaptor->types = types;
  Type::Base *t = 0;
  if (types.front()->is(Type::LIST))
    t = types.front()->component();
  else
    t = types.front();
  Type::Range *range = new Type::Range(t);
  types.clear();
  types.push_back(range);
  Expr::Fn_Call *get_range = new Expr::Fn_Call(Expr::Fn_Call::GET_RANGE);
  get_range->add_arg(names.front());
  Statement::Var_Decl *v = new Statement::Var_Decl(range,
      "range", get_range);
  adaptor->stmts.clear();
  adaptor->stmts.push_back(v);

  Expr::Fn_Call *fn = new Expr::Fn_Call(&target_name_);
  fn->add_arg(*v);
  Statement::Return *ret = new Statement::Return(fn);
  adaptor->stmts.push_back(ret);
}

void Fn_Def::add_simple_choice_fn_adaptor()
{
  assert(adaptor);
  types = adaptor->types;
  adaptor = 0;
  stmts.push_front(new Statement::Return(names.front()));
}

void Fn_Def::codegen_choice(Fn_Def &a, Fn_Def &b, Product::Two &product)
{
  if (!product.is(Product::NOP))
    init_range_iterator();

  switch (product.type()) {
    case Product::TIMES :
      codegen_times(a, b, product);
      break;
    case Product::NOP :
      codegen_nop(a, b, product);
      break;
    case Product::CARTESIAN :
      codegen_cartesian(a, b, product);
      break;
    case Product::TAKEONE :
      codegen_takeone(a, b, product);
      break;
    default:
      assert(false);
  }
}

#include "statement/fn_call.hh"

void Fn_Def::codegen_times(Fn_Def &a, Fn_Def &b, Product::Two &product)
{
  assert(stmts.empty());
  Statement::Var_Decl *answers = new Statement::Var_Decl(
      return_type, "answers");
  stmts.push_back(answers);
  stmts.push_back(new Statement::Fn_Call(Statement::Fn_Call::EMPTY, *answers));

  Expr::Fn_Call *splice_left = new Expr::Fn_Call(Expr::Fn_Call::SPLICE_LEFT);
  splice_left->add_arg(names.front());

  Statement::Var_Decl *left = new Statement::Var_Decl(
      new Type::Range(return_type->left(), return_type, Type::Range::LEFT), "left", splice_left);
  stmts.push_back(left);

  Expr::Fn_Call *h_left = new Expr::Fn_Call(new std::string(a.target_name()));
  h_left->add_arg(*left);

  Statement::Var_Decl *left_answers = new Statement::Var_Decl(
      a.return_type, "left_answers", h_left);
  stmts.push_back(left_answers);

  Expr::Fn_Call *isEmpty = new Expr::Fn_Call(Expr::Fn_Call::IS_EMPTY);
  isEmpty->add_arg(*left_answers);
  Statement::If *if_empty =
    new Statement::If(isEmpty);
  stmts.push_back(if_empty);
  Statement::Var_Decl *temp = new Statement::Var_Decl(return_type, "temp");
  if_empty->then.push_back(temp);
  if_empty->then.push_back(
      new Statement::Fn_Call(Statement::Fn_Call::EMPTY, *temp));
  if_empty->then.push_back(new Statement::Fn_Call(Statement::Fn_Call::ERASE,
        *left_answers));
  if_empty->then.push_back(new Statement::Return(*temp));

  Statement::Var_Decl *elem = new Statement::Var_Decl(
      return_type->left(), "elem");
 
  std::list<Statement::Base*> *loop_body = &stmts; 
  if (product.left_mode(*name).number == Mode::ONE) {
    stmts.push_back(elem);
    elem->rhs = new Expr::Vacc(*left_answers);
  } else {
    Statement::Foreach *loop1 = new Statement::Foreach(elem, left_answers);
    loop1->set_itr(true);
    stmts.push_back(loop1);
    loop_body = &loop1->statements;
  }

  if (b.choice_mode() == Mode::PRETTY) {
    times_cg_without_rhs_choice(a, b, product, answers, loop_body, elem);
  }
  else
    times_cg_with_rhs_choice(a, b, product, answers, loop_body, elem);

  Statement::Return *ret = new Statement::Return(*answers);
  stmts.push_back(ret);
}

void Fn_Def::times_cg_with_rhs_choice
  (Fn_Def &a, Fn_Def &b, Product::Two &product,
   Statement::Var_Decl *answers, std::list<Statement::Base*> *loop_body,
   Statement::Var_Decl *elem)
{
  Statement::Var_Decl *right_candidates = new Statement::Var_Decl(
      new Type::List(return_type->right()), "right_candidates");
  loop_body->push_back(right_candidates);
  loop_body->push_back(
      new Statement::Fn_Call(Statement::Fn_Call::EMPTY, *right_candidates));

  Statement::Var_Decl *input_list = new Statement::Var_Decl(
      types.front(), names.front() /*"input_list"*/,
      new Expr::Vacc(names.front()));
  //loop_body->push_back(input_list);
  Statement::Var_Decl *tupel = new Statement::Var_Decl(return_type->component(),
      "tupel");
  //loop_body->push_back(tupel);

  Statement::Foreach *loop2 = new Statement::Foreach(tupel, input_list);
  loop2->set_itr(true);
  loop_body->push_back(loop2);
  std::list<Statement::Base*> *loop_body2 = &loop2->statements;

  Statement::If *if_eq = new Statement::If(new Expr::Eq(tupel->left(), elem));
  loop_body2->push_back(if_eq);

  Statement::Fn_Call *push_back =
    new Statement::Fn_Call(Statement::Fn_Call::PUSH_BACK);
  push_back->add_arg(*right_candidates);
  push_back->add_arg(tupel->right());
  if_eq->then.push_back(push_back);

  Expr::Fn_Call *h_right = new Expr::Fn_Call(new std::string(b.target_name()));
  h_right->add_arg(*right_candidates);

  Statement::Var_Decl *right_answers = new Statement::Var_Decl(
      b.return_type, "right_answers", h_right);
  loop_body->push_back(right_answers);

  Statement::Var_Decl *right_elem = new Statement::Var_Decl(
      return_type->right(), "right_elem");

  std::list<Statement::Base*> *loop_body3 = loop_body;
  if (product.right_mode(*name).number == Mode::ONE) {
    loop_body->push_back(right_elem);
    Statement::Var_Assign *t =
      new Statement::Var_Assign(*right_elem, *right_answers);
    loop_body3->push_back(t);
  } else {
    Statement::Foreach *loop3 =
      new Statement::Foreach(right_elem, right_answers);
    loop3->set_itr(true);
    loop_body3->push_back(loop3);
    loop_body3 = &loop3->statements;
  }

  Statement::Fn_Call *pb =
    new Statement::Fn_Call(Statement::Fn_Call::PUSH_BACK);

  Statement::Var_Decl *temp_elem = new Statement::Var_Decl(
      return_type->component(), "temp_elem");
  loop_body3->push_back(temp_elem);
  Statement::Var_Assign *l_ass = new Statement::Var_Assign(temp_elem->left(),
      *elem);
  loop_body3->push_back(l_ass);
  Statement::Var_Assign *r_ass = new Statement::Var_Assign(temp_elem->right(),
      *right_elem);
  loop_body3->push_back(r_ass);
  pb->add_arg(*answers);
  pb->add_arg(*temp_elem);

  if (mode_.number == Mode::ONE) {
    Statement::Var_Assign *t = new Statement::Var_Assign(*answers, *temp_elem);
    loop_body3->push_back(t);
  } else {
    loop_body3->push_back(pb);
  }
}

void Fn_Def::times_cg_without_rhs_choice
  (Fn_Def &a, Fn_Def &b, Product::Two &product,
   Statement::Var_Decl *answers, std::list<Statement::Base*> *loop_body,
   Statement::Var_Decl *elem)
{
  Statement::Var_Decl *input_list = new Statement::Var_Decl(
      types.front(), names.front(), new Expr::Vacc(names.front()));
  Statement::Var_Decl *tupel =
    new Statement::Var_Decl(return_type->component(), "tupel");

  Statement::Foreach *loop2 = new Statement::Foreach(tupel, input_list);
  loop2->set_itr(true);
  loop_body->push_back(loop2);
  std::list<Statement::Base*> *loop_body2 = &loop2->statements;

  Statement::If *if_eq = new Statement::If(new Expr::Eq(tupel->left(), elem));
  loop_body2->push_back(if_eq);

  switch (product.type()) {
    case Product::TIMES:
      {
      Statement::Fn_Call *push_back =
        new Statement::Fn_Call(Statement::Fn_Call::PUSH_BACK);
      push_back->add_arg(*answers);
      push_back->add_arg(*tupel);
      if_eq->then.push_back(push_back);
      if (product.no_coopt_class())
        if_eq->then.push_back(new Statement::Break());
      }
      break;
    case Product::TAKEONE:
      {
      Statement::Return *ret = new Statement::Return(*tupel);
      if_eq->then.push_back(ret);
      Statement::Fn_Call *check = new Statement::Fn_Call(
          Statement::Fn_Call::ASSERT);
      check->add_arg(new Expr::Const(0));
      loop_body->push_back(check);
      }
      break;
    default:
      assert(false);
  }
}

void Fn_Def::codegen_takeone(Fn_Def &a, Fn_Def &b, Product::Two &product)
{
  assert(product.left_mode(*name).number == Mode::ONE);
  codegen_times(a, b, product);
}

void Fn_Def::codegen_nop(Fn_Def &a, Fn_Def &b, Product::Two &product)
{
  assert(stmts.empty());
  Statement::Return *ret =
    new Statement::Return(new Expr::Vacc(names.front()));
  stmts.push_back(ret);
}

#include "var_acc.hh"

void Fn_Def::codegen_cartesian(Fn_Def &a, Fn_Def &b, Product::Two &product)
{
  // FIXME answers is no list?
  assert(stmts.empty());
  Statement::Var_Decl *answers = new Statement::Var_Decl(
      return_type, "answers");
  stmts.push_back(answers);

  Expr::Fn_Call *splice_left = new Expr::Fn_Call(Expr::Fn_Call::SPLICE_LEFT);
  splice_left->add_arg(names.front());
  Statement::Var_Decl *left = new Statement::Var_Decl(
      new Type::Range(return_type->left(), return_type, Type::Range::LEFT),
      "left", splice_left);
  stmts.push_back(left);

  Expr::Fn_Call *splice_right = new Expr::Fn_Call(Expr::Fn_Call::SPLICE_RIGHT);
  splice_right->add_arg(names.front());
  Statement::Var_Decl *right = new Statement::Var_Decl(
      new Type::Range(return_type->right(), return_type, Type::Range::RIGHT),
      "right", splice_right);
  stmts.push_back(right);

  Expr::Fn_Call *h_l = new Expr::Fn_Call(new std::string(a.target_name()));
  h_l->add_arg(*left);
  Statement::Var_Assign *l = new Statement::Var_Assign(
    new Var_Acc::Comp(*answers, 0), h_l);
  stmts.push_back(l);

  Expr::Fn_Call *h_r = new Expr::Fn_Call(new std::string(b.target_name()));
  h_r->add_arg(*right);
  Statement::Var_Assign *r = new Statement::Var_Assign(
    new Var_Acc::Comp(*answers, 1), h_r);
  stmts.push_back(r);

  Statement::Return *ret = new Statement::Return(*answers);
  stmts.push_back(ret);
}

void Fn_Def::remove_return_list()
{
  if (stmts.empty())
    return;
  Statement::Base *s = stmts.back();
  if (!s->is(Statement::RETURN)) {
      Log::instance()->warning(location,
          "Last statement is not return - cannot eliminate list.");
      return;
  }
  Statement::Return *ret = dynamic_cast<Statement::Return*>(s);
  assert(ret);
  Expr::Base *l = ret->expr;
  if (!l->is(Expr::FN_CALL)) {
      Log::instance()->warning(location,
          "Return does not call a function - cannot eliminate list.");
      return;
  }
  Expr::Fn_Call *list = dynamic_cast<Expr::Fn_Call*>(l);
  assert(list);
  if (list->builtin != Expr::Fn_Call::LIST) {
      Log::instance()->warning(location,
          "Return does not call the list function - cannot eliminate list.");
      return;
  }
  ret->expr = list->exprs.front();
  delete list;
}

Mode Fn_Def::derive_role() const
{
  Mode r;
  r.set(Yield::UP);
  if (!stmts.back()->is(Statement::RETURN))
    return r;
  Statement::Return *ret = dynamic_cast<Statement::Return*>(stmts.back());
  assert(ret);
  if (!ret->expr->is(Expr::FN_CALL)) {
    if (ret->expr->is(Expr::VACC)) {
      Expr::Vacc *vacc = dynamic_cast<Expr::Vacc*>(ret->expr);
      assert(vacc);
      if (*vacc->name() == *names.front())
        r.set(Mode::PRETTY);
    }
    return r;
  }
  Expr::Fn_Call *fn = dynamic_cast<Expr::Fn_Call*>(ret->expr);
  assert(fn);
  if (fn->builtin == Expr::Fn_Call::UNIQUE) {
    r.set(Mode::CLASSIFY);
    return r;
  }
  if (fn->builtin != Expr::Fn_Call::LIST)
    return r;
  if (!fn->exprs.front()->is(Expr::FN_CALL))
    return r;
  fn = dynamic_cast<Expr::Fn_Call*>(fn->exprs.front());
  assert(fn);
  switch (fn->builtin) {
    case Expr::Fn_Call::SUM :
    case Expr::Fn_Call::EXPSUM :
    case Expr::Fn_Call::EXP2SUM :
    case Expr::Fn_Call::BITSUM :
      r.set(Mode::SYNOPTIC);
      break;
    case Expr::Fn_Call::MINIMUM :
    case Expr::Fn_Call::MAXIMUM :
      r.set(Mode::SCORING);
      break;
    default:
      break;
  }
  return r;
}

Expr::Fn_Call::Builtin Fn_Def::choice_fn_type() const
{
  if (!choice_fn) {
    assert(choice_fn_type_ != Expr::Fn_Call::NONE);
    return choice_fn_type_;
  }
  //assert(!stmts.empty());
  if (stmts.empty())
    return Expr::Fn_Call::NONE;
  if (!stmts.back()->is(Statement::RETURN))
    return Expr::Fn_Call::NONE;
  Statement::Return *ret = dynamic_cast<Statement::Return*>(stmts.back());
  assert(ret);
  if (!ret->expr->is(Expr::FN_CALL)) {
    if (ret->expr->is(Expr::VACC)) {
      Expr::Vacc *vacc = dynamic_cast<Expr::Vacc*>(ret->expr);
      assert(vacc);
      // FIXME
      //if (*vacc->name() == *names.front())
      //  ;
    }
    return Expr::Fn_Call::NONE;
  }
  Expr::Fn_Call *fn = dynamic_cast<Expr::Fn_Call*>(ret->expr);
  assert(fn);
  if (fn->builtin == Expr::Fn_Call::UNIQUE) {
    return fn->builtin;
  }
  if (fn->builtin != Expr::Fn_Call::LIST)
    return fn->builtin;
  if (!fn->exprs.front()->is(Expr::FN_CALL))
    return Expr::Fn_Call::NONE;
  fn = dynamic_cast<Expr::Fn_Call*>(fn->exprs.front());
  assert(fn);
  return fn->builtin;
}

void Fn_Def::set_mode(std::string *s)
{
  if (!s)
    return;
  bool b = mode_.set(*s);
  assert(b);
}

void Fn_Def::reduce_return_type()
{
  ::Type::Base *t = return_type;
  ::Type::List *l = dynamic_cast< ::Type::List*>(t->simple());
  assert(l);
  t = l->of;
  return_type = t;
  remove_return_list();
}


void Fn_Def::install_choice_filter(Filter &filter)
{
  assert(choice_fn);
  Fn_Def *fn = adaptor;
  // ok, if Product::Nop, i.e. if product shuffle opt was applied
  //assert(fn);
  if (!fn)
    fn = this;
  else {
    /* FIXME allows filter with choice fns - remove this code
    Statement::Fn_Call *a = new Statement::Fn_Call(Statement::Fn_Call::ASSERT);
    // FIXME add bool support to Const::
    a->add_arg(new Expr::Const(0));
    stmts.push_front(a);
    */
  }
  if (!fn->types.front()->is(Type::LIST)) {
    Log::instance()->error("Can't filter non-list answer type.");
    return;
  }
  std::string *orig = new std::string(*fn->names.front() + "_orig");
  Statement::Var_Decl *cont = new Statement::Var_Decl(fn->types.front(),
      orig);
  Expr::Fn_Call *filter_fn = new Expr::Fn_Call(filter);
  filter_fn->add_arg(*cont);
  Statement::Var_Decl *v = new Statement::Var_Decl(fn->types.front(),
      fn->names.front(), filter_fn);
  fn->names.erase(fn->names.begin());

  Para_Decl::Simple *s = dynamic_cast<Para_Decl::Simple*>(fn->paras.front());
  assert(s);
  s->replace(orig);

  fn->names.push_back(orig);
  fn->stmts.push_front(v);
}


void Fn_Def::optimize_classify()
{
  adaptor = 0;
  std::list<Statement::Base*> s;
  s.push_back(stmts.front());

  Statement::Var_Decl *answers = dynamic_cast<Statement::Var_Decl*>
    (stmts.front());
  assert(answers);

  Statement::Fn_Call *app =
    new Statement::Fn_Call(Statement::Fn_Call::APPEND_FILTER);
  app->add_arg(*answers);
  app->add_arg(new Expr::Vacc(names.front()));
  s.push_back(app);

  Statement::Fn_Call *fin =
    new Statement::Fn_Call(Statement::Fn_Call::FINALIZE);
  fin->add_arg(*answers);
  s.push_back(fin);

  s.push_back(stmts.back());

  stmts = s;
}


void Fn_Def::add_choice_specialization()
{
  assert(!adaptor || !adaptor->adaptor);

  bool is_list_opt = false;

  Fn_Def *x = new Fn_Def(*this);
  Fn_Def *y = 0;
  if (adaptor)
    y = new Fn_Def(*adaptor);
  else
    is_list_opt = true;
  x->adaptor = y;
  if (y)
    adaptor->adaptor = x;
  else
    adaptor = x;

  if (is_list_opt) {
    Type::Base *t = x->types.front()->component()->left();
    assert(t);
    x->add_para(new Type::Referencable(t), new std::string("left"));
    return;
  }

  for (Statement::iterator i = Statement::begin(x->stmts); i != Statement::end();
       ++i) {
    Statement::Base *s = *i;
    if (s->is(Statement::VAR_DECL)) {
      Statement::Var_Decl *v = dynamic_cast<Statement::Var_Decl*>(s);
      if (*v->name == "left") {
        v = v->clone();
        v->disable();
        *i = v;

        ++i;
        Statement::Var_Decl *w = dynamic_cast<Statement::Var_Decl*>(*i);
        assert(w);
        w = w->clone();
        x->add_para(new Type::Referencable(w->type), w->name);

        y->add_para(new Type::Referencable(w->type), w->name);

        Statement::Return *r = dynamic_cast<Statement::Return*>
          (y->stmts.back());
        assert(r);
        Expr::Fn_Call *f = dynamic_cast<Expr::Fn_Call*>(r->expr);
        assert(f);
        f = f->clone();
        f->add_arg(*w);

        w->disable();
        *i = w;
        break;
      }
    }
  }
}

void Fn_Def::replace_types(std::pair<std::string*, Type::Base*> &alph,
      std::pair<std::string*, Type::Base*> &answer)
{
  Fn_Decl::replace_types(alph, answer);
  assert(paras.size() == types.size());
  std::list<Para_Decl::Base*>::iterator j = paras.begin();
  for (std::list<Type::Base*>::iterator i = types.begin(); i!=types.end();
      ++i, ++j)
    (*j)->replace(*i);
}

Fn_Def *Fn_Def::copy_head(Type::Base *t, std::string *s)
{
  Fn_Def *f = new Fn_Def(t, s);
  f->types = types;
  f->names = names;
  f->paras = paras;
  return f;
}

void Fn_Def::set_ntparas(std::list<Para_Decl::Base*> *l)
{
  if (!l)
    return;
  ntparas_ = *l;
  for (std::list<Para_Decl::Base*>::iterator i = ntparas_.begin();
       i != ntparas_.end(); ++i) {
    Para_Decl::Simple *s = dynamic_cast<Para_Decl::Simple*>(*i);
    assert(s);
    nttypes_.push_back(s->type());
  }
}

bool Fn_Def::check_ntparas(const Fn_Decl &d)
{
  if (ntparas_.size() != d.nttypes().size()) {
    Log::instance()->error(location, "Number of nt parameters does not");
    Log::instance()->error(d.location, "match.");
    return false;
  }
  bool r = true;
  std::list<Type::Base*>::const_iterator j = d.nttypes().begin();
  for (std::list<Para_Decl::Base*>::iterator i = ntparas_.begin(); i != ntparas_.end();
       ++i, ++j) {
    Para_Decl::Simple *s = dynamic_cast<Para_Decl::Simple*>(*i);
    if (!s) {
      Log::instance()->error((*i)->location(), "No simple parameter.");
      r = false;
      continue;
    }
    if (!s->type()->is_eq(**j)) {
      Log::instance()->error(s->location(), "Types does not");
      Log::instance()->error((*j)->location, "match.");
      r = false;
    }
  }
  return r;
}

Fn_Def *Fn_Def::copy() const
{
  Fn_Def *o = new Fn_Def(*this);
  o->name = new std::string(*name);
  o->stmts.clear();
  for (std::list<Statement::Base*>::const_iterator i = stmts.begin(); i != stmts.end(); ++i)
    o->stmts.push_back((*i)->copy());
  o->names.clear();
  for (std::list<std::string*>::const_iterator i = names.begin(); i != names.end(); ++i)
    o->names.push_back(new std::string(**i));
  o->paras.clear();
  for (std::list<Para_Decl::Base*>::const_iterator i = paras.begin(); i != paras.end(); ++i)
    o->paras.push_back((*i)->copy());
  return o;
}

